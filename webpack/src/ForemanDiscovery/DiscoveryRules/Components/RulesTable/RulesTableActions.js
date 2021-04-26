import { get } from 'foremanReact/redux/API';

import {
  GET_DISCOVERY_RULES,
  DISCOVERY_RULES_PATH,
} from './RulesTableConstants';

export const fetchDiscoveryRules = () => dispatch => {
  dispatch(
    get({
      key: GET_DISCOVERY_RULES,
      url: DISCOVERY_RULES_PATH,
    })
  );
};
