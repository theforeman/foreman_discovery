import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import { selectAPIResponse } from 'foremanReact/redux/API/APISelectors';
import * as actions from './RulesTableActions';
import RulesTable from './RulesTable';
import RulesTableReducer from './RulesTableReducer';
import { GET_DISCOVERY_RULES } from './RulesTableConstants';

// map state to props
const mapStateToProps = state => ({
  rules: selectAPIResponse(state, GET_DISCOVERY_RULES).results || [],
});

// map action dispatchers to props
const mapDispatchToProps = dispatch => bindActionCreators(actions, dispatch);

// export reducers
export const reducers = { table: RulesTableReducer };

// export connected component
export default connect(mapStateToProps, mapDispatchToProps)(RulesTable);
