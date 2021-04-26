import Immutable from 'seamless-immutable';

export default (state = Immutable({ rules: [] }), action) => {
  switch (action.type) {
    case 'GET_DISCOVERY_RULES':
      return state.merge({ rules: action.payload });
    default:
      return state;
  }
};
