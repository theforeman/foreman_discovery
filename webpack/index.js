/* eslint import/no-unresolved: [2, { ignore: [foremanReact/*] }] */
/* eslint-disable import/no-extraneous-dependencies */
/* eslint-disable import/extensions */
import componentRegistry from 'foremanReact/components/componentRegistry';
import { registerReducer } from 'foremanReact/common/MountingService';
import reducers from './src/reducers';
import DiscoveredHosts from './src/ForemanDiscovery/DiscoveredHosts';
import DiscoveryRules from './src/ForemanDiscovery/DiscoveryRules';

// register reducers
Object.entries(reducers).forEach(([key, reducer]) =>
  registerReducer(key, reducer)
);

// register components for erb mounting
componentRegistry.registerMultiple([
  { name: 'DiscoveredHosts', type: DiscoveredHosts },
  { name: 'DiscoveryRules', type: DiscoveryRules },
]);
