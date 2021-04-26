import React from 'react';
import { registerRoutes as foremanRegisterRoutes } from 'foremanReact/routes/RoutingService';
import DiscoveryRules from './src/ForemanDiscovery/DiscoveryRules/Components/RulesTable';

export const routes = [
  {
    path: '/discovery_rules_test',
    exact: true,
    render: props => <DiscoveryRules {...props} />,
  },
];

export const registerRoutes = () => {
  foremanRegisterRoutes('foreman_discovery', routes);
};
