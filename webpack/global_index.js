import { registerReducer } from 'foremanReact/common/MountingService';
import reducers from './src/reducers';
import { registerRoutes } from './ForemanDiscoveryRoutes';

// register reducers
Object.entries(reducers).forEach(([key, reducer]) =>
  registerReducer(key, reducer)
);

registerRoutes();
