const tfmConfig = require('@theforeman/test/src/pluginConfig');
const { foremanRelativePath, foremanLocation } = require('@theforeman/find-foreman');

const foremanReactRelative = 'webpack/assets/javascripts/react_app';
const foremanFull = foremanLocation();
const foremanReactFull = foremanRelativePath(foremanReactRelative);

tfmConfig.moduleNameMapper['^foremanReact(.*)$'] = `${foremanReactFull}/$1`;

tfmConfig.resolver = null;
tfmConfig.moduleDirectories = [
  `${foremanFull}/node_modules`,
  `${foremanFull}/node_modules/@theforeman/vendor-core/node_modules`,
  'node_modules',
];

tfmConfig.setupFilesAfterEnv = [
  ...(tfmConfig.setupFilesAfterEnv || []),
  '@testing-library/jest-dom',
];

module.exports = tfmConfig;
