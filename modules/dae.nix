{ pkgs, username, ... }:
let
  subscriptionEnv = builtins.getEnv "NIX_DAE_SUBSCRIPTION";
  subscriptions = if subscriptionEnv == "" then [ ] else builtins.split ";" subscriptionEnv;
in
{
  services.dae = {
    enable = if builtins.length subscriptions == 0 then false else true;
    assets = with pkgs; [ v2ray-geoip v2ray-domain-list-community ];

    config = ''
      global {
        # 绑定到 LAN 和/或 WAN 接口。将下述接口替换成你自己的接口名。
        #lan_interface: docker0
        wan_interface: auto # 使用 "auto" 自动侦测 WAN 接口。

        log_level: info
        allow_insecure: false
        auto_config_kernel_parameter: true
      }

      subscription {
        # 在下面填入你的订阅链接。
      }

      # 更多的 DNS 样例见 https://github.com/daeuniverse/dae/blob/main/docs/en/configuration/dns.md
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

      # 更多的 Routing 样例见 https://github.com/daeuniverse/dae/blob/main/docs/en/configuration/routing.md
      routing {
        pname(NetworkManager) -> direct
        dip(224.0.0.0/3, 'ff00::/8') -> direct

        ### 以下为自定义规则

        # 禁用 h3，因为它通常消耗很多 CPU 和内存资源
        l4proto(udp) && dport(443) -> block
        dip(geoip:private) -> direct
        dip(geoip:cn) -> direct
        domain(geosite:cn) -> direct

        fallback: proxy
      }
    '';
  };
}
