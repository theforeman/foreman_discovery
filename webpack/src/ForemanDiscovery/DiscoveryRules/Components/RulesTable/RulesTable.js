import React, { useEffect } from 'react';
import PropTypes from 'prop-types';
import { Table, TableHeader, TableBody } from '@patternfly/react-table';
import { cells } from './RulesTableConstants';

const RulesTable = ({ rules, fetchDiscoveryRules }) => {
  // acts as componentDidMount
  useEffect(() => {
    fetchDiscoveryRules();
  }, []);

  const rows =
    rules.length === 0
      ? []
      : rules
          .asMutable()
          .map(
            ({
              name,
              priority,
              search,
              hostgroup_id,
              hosts_limit,
              enabled,
              id,
            }) => ({
              cells: [
                name,
                priority,
                search,
                hostgroup_id,
                hosts_limit,
                enabled,
                id,
              ],
            })
          );

  return (
    <Table aria-label="Discovery Rules" cells={cells} rows={rows}>
      <TableHeader />
      <TableBody />
    </Table>
  );
};

RulesTable.propTypes = {
  rules: PropTypes.array.isRequired,
  fetchDiscoveryRules: PropTypes.func.isRequired,
};

export default RulesTable;
