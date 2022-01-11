
const div = (attrs = {}) => {
    const el = document.createElement('div');
    if (attrs.class) {
        el.className = attrs.class;
    }
    if (attrs.innerHTML) {
        el.innerHTML = attrs.innerHTML;
    }
    return el;
}
const addNewStyle = (newStyle) => {
    let styleElement = document.getElementById('styles_js');

    if (!styleElement) {
        styleElement = document.createElement('style');
        styleElement.type = 'text/css';
        styleElement.id = 'styles_js';
        document.getElementsByTagName('head')[0].appendChild(styleElement);
        styleElement.appendChild(document.createTextNode(newStyle));
    }

}
const cssString = `
.container {
    font-family: sans-serif;
}
.page {}
.page-grid {
    display: grid;
    grid-template-columns: 1fr 0.0625fr 1fr;
    width: 100%;
}
.page-none {
  display:none;
}
.border {
    border: 1px black solid;
}
.dotted-border {
    border: 1px black dotted;
}
.shrink {
    transform: scale(0.6);
}
`;
//图像处理
const putBinaryImageData = (ctx, imgData, transferMaps = null) => {

    const FULL_CHUNK_HEIGHT = 16;

    const ImageKind = {
        GRAYSCALE_1BPP: 1,
        RGB_24BPP: 2,
        RGBA_32BPP: 3
    };

    if (typeof ImageData !== "undefined" && imgData instanceof ImageData) {
        ctx.putImageData(imgData, 0, 0);
        return;
    }

    const height = imgData.height,
        width = imgData.width;
    const partialChunkHeight = height % FULL_CHUNK_HEIGHT;
    const fullChunks = (height - partialChunkHeight) / FULL_CHUNK_HEIGHT;
    const totalChunks = partialChunkHeight === 0 ? fullChunks : fullChunks + 1;
    const chunkImgData = ctx.createImageData(width, FULL_CHUNK_HEIGHT);
    let srcPos = 0,
        destPos;
    const src = imgData.data;
    const dest = chunkImgData.data;
    let i, j, thisChunkHeight, elemsInThisChunk;
    let transferMapRed, transferMapGreen, transferMapBlue, transferMapGray;

    if (transferMaps) {
        switch (transferMaps.length) {
            case 1:
                transferMapRed = transferMaps[0];
                transferMapGreen = transferMaps[0];
                transferMapBlue = transferMaps[0];
                transferMapGray = transferMaps[0];
                break;

            case 4:
                transferMapRed = transferMaps[0];
                transferMapGreen = transferMaps[1];
                transferMapBlue = transferMaps[2];
                transferMapGray = transferMaps[3];
                break;
        }
    }

    if (imgData.kind === ImageKind.GRAYSCALE_1BPP) {
        const srcLength = src.byteLength;
        const dest32 = new Uint32Array(dest.buffer, 0, dest.byteLength >> 2);
        const dest32DataLength = dest32.length;
        const fullSrcDiff = width + 7 >> 3;
        let white = 0xffffffff;
        let black = _util.IsLittleEndianCached.value ? 0xff000000 : 0x000000ff;

        if (transferMapGray) {
            if (transferMapGray[0] === 0xff && transferMapGray[0xff] === 0) {
                [white, black] = [black, white];
            }
        }

        for (i = 0; i < totalChunks; i++) {
            thisChunkHeight = i < fullChunks ? FULL_CHUNK_HEIGHT : partialChunkHeight;
            destPos = 0;

            for (j = 0; j < thisChunkHeight; j++) {
                const srcDiff = srcLength - srcPos;
                let k = 0;
                const kEnd = srcDiff > fullSrcDiff ? width : srcDiff * 8 - 7;
                const kEndUnrolled = kEnd & ~7;
                let mask = 0;
                let srcByte = 0;

                for (; k < kEndUnrolled; k += 8) {
                    srcByte = src[srcPos++];
                    dest32[destPos++] = srcByte & 128 ? white : black;
                    dest32[destPos++] = srcByte & 64 ? white : black;
                    dest32[destPos++] = srcByte & 32 ? white : black;
                    dest32[destPos++] = srcByte & 16 ? white : black;
                    dest32[destPos++] = srcByte & 8 ? white : black;
                    dest32[destPos++] = srcByte & 4 ? white : black;
                    dest32[destPos++] = srcByte & 2 ? white : black;
                    dest32[destPos++] = srcByte & 1 ? white : black;
                }

                for (; k < kEnd; k++) {
                    if (mask === 0) {
                        srcByte = src[srcPos++];
                        mask = 128;
                    }

                    dest32[destPos++] = srcByte & mask ? white : black;
                    mask >>= 1;
                }
            }

            while (destPos < dest32DataLength) {
                dest32[destPos++] = 0;
            }

            ctx.putImageData(chunkImgData, 0, i * FULL_CHUNK_HEIGHT);
        }
    } else if (imgData.kind === ImageKind.RGBA_32BPP) {
        const hasTransferMaps = !!(transferMapRed || transferMapGreen || transferMapBlue);
        j = 0;
        elemsInThisChunk = width * FULL_CHUNK_HEIGHT * 4;

        for (i = 0; i < fullChunks; i++) {
            dest.set(src.subarray(srcPos, srcPos + elemsInThisChunk));
            srcPos += elemsInThisChunk;

            if (hasTransferMaps) {
                for (let k = 0; k < elemsInThisChunk; k += 4) {
                    if (transferMapRed) {
                        dest[k + 0] = transferMapRed[dest[k + 0]];
                    }

                    if (transferMapGreen) {
                        dest[k + 1] = transferMapGreen[dest[k + 1]];
                    }

                    if (transferMapBlue) {
                        dest[k + 2] = transferMapBlue[dest[k + 2]];
                    }
                }
            }

            ctx.putImageData(chunkImgData, 0, j);
            j += FULL_CHUNK_HEIGHT;
        }

        if (i < totalChunks) {
            elemsInThisChunk = width * partialChunkHeight * 4;
            dest.set(src.subarray(srcPos, srcPos + elemsInThisChunk));

            if (hasTransferMaps) {
                for (let k = 0; k < elemsInThisChunk; k += 4) {
                    if (transferMapRed) {
                        dest[k + 0] = transferMapRed[dest[k + 0]];
                    }

                    if (transferMapGreen) {
                        dest[k + 1] = transferMapGreen[dest[k + 1]];
                    }

                    if (transferMapBlue) {
                        dest[k + 2] = transferMapBlue[dest[k + 2]];
                    }
                }
            }

            ctx.putImageData(chunkImgData, 0, j);
        }
    } else if (imgData.kind === ImageKind.RGB_24BPP) {
        const hasTransferMaps = !!(transferMapRed || transferMapGreen || transferMapBlue);
        thisChunkHeight = FULL_CHUNK_HEIGHT;
        elemsInThisChunk = width * thisChunkHeight;

        for (i = 0; i < totalChunks; i++) {
            if (i >= fullChunks) {
                thisChunkHeight = partialChunkHeight;
                elemsInThisChunk = width * thisChunkHeight;
            }

            destPos = 0;

            for (j = elemsInThisChunk; j--;) {
                dest[destPos++] = src[srcPos++];
                dest[destPos++] = src[srcPos++];
                dest[destPos++] = src[srcPos++];
                dest[destPos++] = 255;
            }

            if (hasTransferMaps) {
                for (let k = 0; k < destPos; k += 4) {
                    if (transferMapRed) {
                        dest[k + 0] = transferMapRed[dest[k + 0]];
                    }

                    if (transferMapGreen) {
                        dest[k + 1] = transferMapGreen[dest[k + 1]];
                    }

                    if (transferMapBlue) {
                        dest[k + 2] = transferMapBlue[dest[k + 2]];
                    }
                }
            }

            ctx.putImageData(chunkImgData, 0, i * FULL_CHUNK_HEIGHT);
        }
    } else {
        throw new Error(`bad image kind: ${imgData.kind}`);
    }
}
const makePageDom = pageNum => {
    const el = div({ class: 'page' });

    const left = div({ class: 'page-none' });
    left.appendChild(div({ innerHTML: `Page ${pageNum}` }));
    const canvasContainer = div();
    const canvas = document.createElement('canvas');
    canvasContainer.appendChild(canvas);
    left.appendChild(canvasContainer);
    el.appendChild(left);

    const right = div();
    right.appendChild(div());
    const specContainer = div({ class: 'border' });
    right.appendChild(specContainer);
    el.appendChild(right);

    return {
        el,
        canvasContainer,
        canvas,
        specContainer,
    };
};

const goFdf = (callback) => {
    var layerIndex = layer.load(1); 
    addNewStyle(cssString);
    const pdfjsLib = window['pdfjs-dist/build/pdf'];
    //console.log('pdfjsLib:', pdfjsLib);
    // See: https://mozilla.github.io/pdf.js/examples/
    // The workerSrc property shall be specified.
    pdfjsLib.GlobalWorkerOptions.workerSrc = '/admin/word/libs/pdf.worker.js';

    const invOps = Object.fromEntries(Object.keys(pdfjsLib.OPS).map(key => [pdfjsLib.OPS[key], key]));
    const imageOps = [
        pdfjsLib.OPS.beginInlineImage,
        pdfjsLib.OPS.beginImageData,
        pdfjsLib.OPS.endInlineImage,
        pdfjsLib.OPS.paintXObject,
        pdfjsLib.OPS.paintFormXObjectBegin,
        pdfjsLib.OPS.paintFormXObjectEnd,
        pdfjsLib.OPS.paintJpegXObject,
        pdfjsLib.OPS.paintImageMaskXObject,
        pdfjsLib.OPS.paintImageMaskXObjectGroup,
        pdfjsLib.OPS.paintImageXObject,
        pdfjsLib.OPS.paintInlineImageXObject,
        pdfjsLib.OPS.paintInlineImageXObjectGroup,
        pdfjsLib.OPS.paintImageXObjectRepeat,
        pdfjsLib.OPS.paintImageMaskXObjectRepeat,
        pdfjsLib.OPS.paintSolidColorImageMask,
    ];
    const textOps = [
        pdfjsLib.OPS.nextLineSetSpacingShowText,
        pdfjsLib.OPS.nextLineShowText,
        pdfjsLib.OPS.setLeading,
        pdfjsLib.OPS.setLeadingMoveText,
        pdfjsLib.OPS.setTextMatrix,
        pdfjsLib.OPS.setTextRenderingMode,
        pdfjsLib.OPS.setTextRise,
        pdfjsLib.OPS.setCharSpacing,
        pdfjsLib.OPS.setWordSpacing,
        pdfjsLib.OPS.setCharWidthAndBounds,
        pdfjsLib.OPS.showText,
    ];
    const otherOps = [
        //pdfjsLib.OPS.dependency,
        pdfjsLib.OPS.transform,
    ];


    //const container = document.getElementById('pages');
    const container = document.createElement('div');
    container.id = 'pages';
    //console.log('container:', container);

    const pdfLoader = async event => {
        console.log('pdfLoader:', event);
        const pdf = await pdfjsLib.getDocument({
            data: event.target.result,
            //disableFontFace: true,
            nativeImageDecoderSupport: 'none',
        }).promise;
        //console.log('pdf.keys:', Object.keys(pdf));
        //console.log('pdf._pdfInfo.keys:', Object.keys(pdf._pdfInfo));

        const numPages = pdf.numPages;
        //console.log(`pdfLoader: numPages ${numPages}`);

        while (container.lastChild) {
            container.removeChild(container.lastChild);
        }

        let pageNum = 0;
        while (++pageNum <= numPages) {
            const page = await pdf.getPage(pageNum);
            const { el, canvasContainer, canvas, specContainer } = makePageDom(pageNum);

            const ptToPx = 96 / 72;
            const scale = ptToPx;
            const viewport = page.getViewport({ scale });
            const containerStyle = `position: relative; width: ${viewport.width}px; height: ${viewport.height}px; font-size: 8pt;`;
            //canvasContainer.setAttribute('style', containerStyle);
            specContainer.setAttribute('style', containerStyle);

            // Canvas uses CSS pixels, 1/96 inches
            canvas.width = viewport.width;
            canvas.height = viewport.height;
            const canvasContext = canvas.getContext('2d');
            // promise
            await page.render({ canvasContext, viewport }).promise;

            container.appendChild(el);

            const textContext = await page.getTextContent({
                normalizeWhitespace: true,
                disableCombineTextItems: false,
            });

            const unscaledViewportHeight = viewport.height / viewport.scale;
            textContext.items.forEach(item => {
                // don't show empty strings
                const isEmpty = item.str.match(/^\s*$/);
                const { width, height, transform, str } = item;
                const [x00, x01, x10, x11, offX, offY] = transform;
                const offY2 = Math.floor(unscaledViewportHeight - offY - height + 1);
                const style = `position: absolute; left: ${offX - 1}pt; top: ${offY2}pt; width: ${width}pt; height: ${height}pt; font-size: ${x11}px;};`;
                // don't pollute user display with empty boxes
                if (isEmpty) return;

                const span = document.createElement('span');
                span.setAttribute('style', style);
                span.innerHTML = str;
                specContainer.appendChild(span);

            });

            const operatorList = await page.getOperatorList();
            let imageNum = 0;
            operatorList.fnArray.forEach((op, index) => {
                const ish =
                    textOps.includes(op) ? 'textish' :
                        imageOps.includes(op) ? 'imageish' :
                            otherOps.includes(op) ? 'otherish' :
                                '';
                //console.log('ish------', ish);
                if (ish === 'imageish') {
                    for (let offset = -2; offset <= 0; ++offset) {
                        const index2 = index + offset;
                        const op2 = operatorList.fnArray[index2];
                    }

                    ++imageNum;
                    //console.log('imageNum:', imageNum);
                    const imageArgs = operatorList.argsArray[index];
                    //console.log('imageArgs ', JSON.stringify(imageArgs));
                    const imageName = imageArgs[0];
                    const imageInfo = page.objs.get(imageName);
                    const { width, height, kind, data } = imageInfo;

                    const transform = operatorList.argsArray[index - 2];
                    if (data) {
                        const [x00, x01, x10, x11, offX, offY] = transform;
                        const offY2 = Math.floor(unscaledViewportHeight - offY);

                        const width2 = transform[0]
                        const height2 = transform[3]
                        //const offY3 = Math.floor((viewport.height - height2) / viewport.scale);
                        const offY3 = offY2 - height2 * viewport.scale;
                        //const offY2 = viewport.height - offY;

                        //图像处理
                        //page.OPS.paintInlineImageXObject(imageInfo)
                        try {
                            let mcanvas = document.createElement('canvas');
                            mcanvas.width = imageInfo.width;
                            mcanvas.height = imageInfo.height;
                            let ctx = mcanvas.getContext('2d');
                            putBinaryImageData(ctx, imageInfo)
                            // ctx.putImageData(idata, 0, 0);
                            let imageSrc = mcanvas.toDataURL('image/png');
                            //console.log(image)
                            const img = document.createElement('img');
                            img.src = imageSrc;
                            img.className = 'dotted-border';
                            let w = width2 * 2,
                                h = height2 * 2;

                            const imgcss = `position: absolute; left: ${offX - 1}pt; top: ${offY2 - height2 - 1}pt; width: ${w}pt; height: ${h}pt;`;
                            img.setAttribute('style', imgcss);
                            specContainer.appendChild(img);

                        } catch (err) {
                            console.log(err.message)
                        }

                    }

                }

            });

        }
        callback(container.innerHTML);
        layer.close(layerIndex)

    }
    //const fileInput = document.getElementById('fileInput');
    const fileInput = document.createElement("input");
    fileInput.type = "file";
    fileInput.id = "fileInput";
    fileInput.click();
    fileInput.onchange = event => {
        console.log('fileInput.onchange:', event);
        const pdfFile = fileInput.files[0];
        if (pdfFile) {
            const fileReader = new FileReader();
            fileReader.onload = pdfLoader;
            fileReader.readAsArrayBuffer(pdfFile);

        }
    };
}