{ pkgs, ... }:
{
  services.dae = {
    enable = true;
    assets = with pkgs; [ v2ray-geoip v2ray-domain-list-community ];

    config = ''
      global {
        #lan_interface: docker0
        wan_interface: auto

        log_level: info
        allow_insecure: false
        auto_config_kernel_parameter: true
      }

      subscription {
        # 在下面填入你的订阅链接。
      }

      dns {
        upstream {
          googledns: 'tcp+udp://dns.google:53'
          alidns: 'udp://dns.alidns.com:53'
        }
        routing {
          request {
            qtype(https) -> reject
            fallback: alidns
          }
          response {
            upstream(googledns) -> accept
            ip(geoip:private) && !qname(geosite:cn) -> googledns
            fallback: accept
          }
        }
      }

      group {
        proxy {
          #filter: name(keyword: HK, keyword: SG)
          policy: min_moving_avg
        }
      }

      routing {
        pname(NetworkManager) -> direct
        dip(224.0.0.0/3, 'ff00::/8') -> direct

        l4proto(udp) && dport(443) -> block
        dip(geoip:private) -> direct
        dip(geoip:cn) -> direct
        domain(geosite:cn) -> direct

        fallback: proxy
      }
    '';
  };
}
