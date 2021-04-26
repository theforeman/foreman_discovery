/* eslint import/no-unresolved: [2, { ignore: [foremanReact/*] }] */
/* eslint-disable import/no-extraneous-dependencies */
/* eslint-disable import/extensions */
import componentRegistry from 'foremanReact/components/componentRegistry';
import DiscoveredHosts from './src/ForemanDiscovery/DiscoveredHosts';
// import DiscoveryRules from './src/ForemanDiscovery/DiscoveryRules/';

// register components for erb mounting
componentRegistry.registerMultiple([
  { name: 'DiscoveredHosts', type: DiscoveredHosts },
  // { name: 'DiscoveryRules', type: DiscoveryRules },
]);
