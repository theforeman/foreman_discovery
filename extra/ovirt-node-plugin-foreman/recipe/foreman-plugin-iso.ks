%include ovirt-node-image.ks
%packages --excludedocs --nobase
ovirt-node-plugin-foreman
%end
%include foreman-plugin-minimizer.ks
