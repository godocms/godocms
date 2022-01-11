const path = require('path');
const Application = require('thinkjs');
const watcher = require('think-watcher');
const babel = require('think-babel');
const notifier = require('node-notifier');
//const open = require('open');
const instance = new Application({
  ROOT_PATH: __dirname,
  APP_PATH: path.join(__dirname, 'app'),
  watcher: watcher,
  // docTranspiler: [jsdoc, {
  //   match: /(controll)/g,
  // }],
  transpiler: [babel, {
    presets: ['think-node']
  }],
  notifier: notifier.notify.bind(notifier),
  env: 'development'
});

instance.run();
//open('http://localhost:8200');
