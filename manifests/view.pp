# ex: syntax=puppet si ts=4 sw=4 et

define bind::view (
    $match_clients                = 'any',
    $match_destinations           = '',
    $zones                        = [],
    $transfer_source              = '',
    $allow_updates                = '',
    $allow_transfers              = '',
    $allow_new_zones              = false,
    $ns_notify                    = true,
    $also_notify                  = '',
    $allow_notify                 = '',
    $forwarders                   = '',
    $forward                      = '',
    $recursion                    = true,
    $recursion_match_clients      = 'any',
    $recursion_match_destinations = '',
    $recursion_match_only         = false,
    $servers                      = '',
    $order                        = '10',
) {
    $confdir = $::bind::confdir

    concat::fragment { "bind-view-${name}":
        order   => $order,
        target  => "${::bind::confdir}/views.conf",
        content => template('bind/view.erb'),
    }
}
