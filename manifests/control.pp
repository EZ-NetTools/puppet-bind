# ex: syntax=puppet si ts=4 sw=4 et

define bind::control (
	$ip_addr = $name,
	$port    = 953,
	$allow   = [],
	$keys    = [],
	$order   = 10,
) {

	if !has_ip_address($ip_addr) {
	    fail("There is no interface on this host with the ip address ${ip_addr}")   
	}

	realize Concat::Fragment['named-controls-start', 'named-controls-end']

	$inet_t = ' inet <%= @ip_addr %>'
	$port_t = ' port <%= @port %>'
	$allow_t = ' allow { <%= Array(@allow).join("; ") + ";" if @allow and @allow.length > 0 %> }'
	$keys_t = '<%- if @keys and @keys.length > 0 -%> keys { <%= Array(@keys).map { |x| \'"\' + x + \'"\' }.join("; ") + ";" %> }<%- end -%>' 

    concat::fragment { "named-controls-${name}":
        order   => $order,
        target  => "${::bind::confdir}/controls.conf",
        content => inline_template($inet_t, $port_t, $allow_t, $keys_t, ";\n"),
    }
}
