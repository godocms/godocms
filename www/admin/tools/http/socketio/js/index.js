hljs.initHighlightingOnLoad();

this.$slideOut = $('#slideOut');

// Slideout show
this.$slideOut.find('.slideOutTab').on('click', () => {
    $('#slideOut').toggleClass('showSlideOut');
});

$("#connect .btn").on('click', function () {
    if ($("#connect .btn").hasClass('btn-success')) {
        $('#slideOut').toggleClass('showSlideOut');
    }
});

$('.close').on('click', function () {
    $('#slideOut').toggleClass('showSlideOut');
})

$('.open-button').on('click', function () {
    $(this).closest('.collapse-group').find('.collapse').collapse('show');
});

$('.close-button').on('click', function () {
    $(this).closest('.collapse-group').find('.collapse').collapse('hide');
});

jQuery(($) => {
    const panelList = $('#eventPanels');

    panelList.sortable({
        // Only make the .panel-heading child elements support dragging.
        // Omit this to make then entire <li>...</li> draggable.
        handle: '.panel-heading',
        update() {
            $('.panel', panelList).each((index, elem) => {
                const $listItem = $(elem);


                const newIndex = $listItem.index();

                // Persist the new indices.
            });
        },
    });
});

jQuery(($) => {
    const panelList2 = $('#eventPanels2');

    panelList2.sortable({
        // Only make the .panel-heading child elements support dragging.
        // Omit this to make then entire <li>...</li> draggable.
        handle: '.panel-heading',
        update() {
            $('.panel', panelList2).each((index, elem) => {
                const $listItem = $(elem);


                const newIndex = $listItem.index();

                // Persist the new indices.
            });
        },
    });


    $(document).ready(() => {
        /** ******************************
	    * Collapse Panels
	    * [data-perform="panel-collapse"]
	    ****************************** * */
        (function ($, window, document) {
            const panelSelector = '[data-perform="panel-collapse"]';

            $(panelSelector).each(function () {
                const $this = $(this);


                const parent = $this.closest('.panel');


                let wrapper = parent.find('.panel-wrapper');


                let collapseOpts = { toggle: false };

                if (!wrapper.length) {
                    wrapper =				parent.children('.panel-heading').nextAll()
				    .wrapAll('<div/>')
				    .parent()
				    .addClass('panel-wrapper');
                    collapseOpts = {};
                }
                wrapper
                    .collapse(collapseOpts)
                    .on('hide.bs.collapse', () => {
                        $this.children('i').removeClass('fa-minus').addClass('fa-plus');
                    })
                    .on('show.bs.collapse', () => {
                        $this.children('i').removeClass('fa-plus').addClass('fa-minus');
                    });
            });
            $(document).on('click', panelSelector, function (e) {
                e.preventDefault();
                const parent = $(this).closest('.panel');
                const wrapper = parent.find('.panel-wrapper');
                wrapper.collapse('toggle');
            });
        }(jQuery, window, document));

        /** ******************************
	 * Remove Panels
	 * [data-perform="panel-dismiss"]
	 ****************************** * */
        (function ($, window, document) {
            const panelSelector = '[data-perform="panel-dismiss"]';
            $(document).on('click', panelSelector, function (e) {
                e.preventDefault();
                const parent = $(this).closest('.panel');
                removeElement();

                function removeElement() {
                    const col = parent.parent();
                    parent.remove();
                    col.filter(function () {
                        const el = $(this);
                        return (el.is('[class*="col-"]') && el.children('*').length === 0);
                    }).remove();
                }
            });
        }(jQuery, window, document));
    });
});


$('.form').find('input, textarea').on('keyup blur focus', function (e) {
    const $this = $(this);


    const label = $this.prev('label');

	  if (e.type === 'keyup') {
        if ($this.val() === '') {
            label.removeClass('active highlight');
        } else {
            label.addClass('active highlight');
        }
    } else if (e.type === 'blur') {
    	if ($this.val() === '') {
    		label.removeClass('active highlight');
        } else {
		    label.removeClass('highlight');
        }
    } else if (e.type === 'focus') {
        if ($this.val() === '') {
    		label.removeClass('highlight');
        } else if ($this.val() !== '') {
		    label.addClass('highlight');
        }
    }
});

$('.tab a').on('click', function (e) {
    e.preventDefault();

    $(this).parent().addClass('active');
    $(this).parent().siblings().removeClass('active');

    target = $(this).attr('href');

    $('.tab-content > div').not(target).hide();

    $(target).fadeIn(600);
});

const editor = ace.edit('editor');
editor.setValue('{}');
editor.setOptions({
    autoScrollEditorIntoView: true,
    theme: 'ace/theme/pastel_on_dark',
    showPrintMargin: false,
    mode: 'ace/mode/json',
});

editor.getSession().on('change', (e) => {
    console.log(editor);
    const val = editor.getValue();
    console.log(val);
});
