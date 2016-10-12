class Announce < ApplicationRecord
  belongs_to :search

  def self.random_desktop_user_agent
    user_agents = [
      "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.64 Safari/537.11",
      "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:16.0) Gecko/20100101 Firefox/16.0",
      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/536.26.17 (KHTML, like Gecko) Version/6.0.2 Safari/536.26.17",
      "Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0)",
      "Mozilla/5.0 (Windows NT 5.1; rv:13.0) Gecko/20100101 Firefox/13.0.1",
      "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; FunWebProducts; .NET CLR 1.1.4322; PeoplePal 6.2)",
      "Mozilla/5.0 (Windows NT 5.1; rv:5.0.1) Gecko/20100101 Firefox/5.0.1",
      "Mozilla/5.0 (Windows NT 6.0) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.112 Safari/535.1",
      "Opera/9.80 (Windows NT 5.1; U; en) Presto/2.10.289 Version/12.01",
      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.95 Safari/537.11",
      "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; Trident/4.0; .NET CLR 2.0.50727; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729)",
      "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1) )",
      "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; SV1; .NET CLR 2.0.50727)",
      "Mozilla/5.0 (Windows NT 6.1; rv:2.0b7pre) Gecko/20100921 Firefox/4.0b7pre",
      "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; Trident/4.0; .NET CLR 1.1.4322)",
      "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.95 Safari/537.11",
      "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0; Trident/4.0; Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1) ; .NET CLR 3.5.30729)",
      "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.95 Safari/537.11",
      "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.112 Safari/535.1",
      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.64 Safari/537.11",
      "Mozilla/4.0 (compatible; MSIE 6.0; MSIE 5.5; Windows NT 5.0) Opera 7.02 Bork-edition [en]",
      "Mozilla/5.0 (Windows NT 6.1; rv:5.0) Gecko/20100101 Firefox/5.02",
      "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.64 Safari/537.11",
      "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:5.0) Gecko/20100101 Firefox/5.0",
      "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; MRA 5.8 (build 4157); .NET CLR 2.0.50727; AskTbPTV/5.11.3.15590)",
      "Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20100101 Firefox/16.0",
      "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.64 Safari/537.11",
      "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20100101 Firefox/17.0",
      "Mozilla/5.0 (Windows NT 6.1; rv:16.0) Gecko/20100101 Firefox/16.0",
      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/534.57.2 (KHTML, like Gecko) Version/5.1.7 Safari/534.57.2",
      "Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)",
      "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.91 Safari/537.11",
      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_5) AppleWebKit/536.26.17 (KHTML, like Gecko) Version/6.0.2 Safari/536.26.17",
      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:16.0) Gecko/20100101 Firefox/16.0",
      "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/17.0 Firefox/17.0",
      "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; TencentTraveler ; Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1) ; .NET CLR 2.0.50727)",
      "Mozilla/5.0 (iPad; CPU OS 6_0_1 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A523 Safari/8536.25",
      "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2) Gecko/20100115 Firefox/3.6",
      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_5) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.64 Safari/537.11",
      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:16.0) Gecko/20100101 Firefox/16.0",
      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_5) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.95 Safari/537.11",
      "Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20100101 Firefox/17.0",
      "Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20100101 Firefox/17.0"]
   return user_agents.sample
  end


  def self.random_desktop_user_agent_mechanize
    user_agents = [
      # "Linux Firefox (43.0 on Ubuntu Linux)",
      # "Linux Konqueror (3)",
      "Linux Mozilla",
      "Mac Firefox (43.0)",
      "Mac Mozilla",
      # "Mac Safari (9.0 on OS X 10.11.2)",
      "Mac Safari 4",
      # "Mechanize (default)",
      "Windows IE 6",
      "Windows IE 7",
      "Windows IE 8",
      "Windows IE 9",
      # "Windows IE 10 (Windows 8 64bit)",
      # "Windows IE 11 (Windows 8.1 64bit)",
      "Windows Edge",
      "Windows Mozilla",
      # "Windows Firefox (43.0)",
      # "iPhone (iOS 9.1)",
      "iPad (iOS 9.1)"
      # "Android (5.1.1)"
      ]
   return user_agents.sample
  end

# 1.0.241.135:8080
# 1.160.1.10:8080
# 1.160.162.170:8080
# 1.160.21.177:8080
# 1.160.3.252:8080
# 1.160.3.84:8080
# 1.160.4.125:8080
# 1.160.5.165:8080
# 1.160.5.215:8080
# 1.160.7.205:8080
# 1.161.154.222:8080
# 1.161.157.151:8080
# 1.161.196.36:3128
# 1.162.217.62:8080
# 1.163.115.33:8088
# 1.163.224.239:8080
# 1.163.224.37:8080
# 1.163.224.52:8080
# 1.163.225.132:8080
# 1.163.227.10:8080
# 1.163.227.163:8080
# 1.163.227.60:8080
# 1.163.228.25:8080
# 1.163.229.103:8080
# 1.163.231.158:8080
# 1.163.231.167:8080
# 1.163.241.132:8080
# 1.163.25.12:8080
# 1.163.25.197:8080
# 1.163.26.149:8080
# 1.163.27.52:8080
# 1.163.29.78:8080
# 1.163.30.181:8080
# 1.163.30.206:8080
# 1.163.30.216:8080
# 1.163.38.54:8080
# 1.163.39.155:8080
# 1.163.39.226:8080
# 1.168.179.207:8088
# 1.171.179.7:8080
# 1.172.21.193:8088
# 1.172.97.142:8080
# 1.173.17.107:8080
# 1.179.185.253:8080
# 1.82.216.135:80
# 1.9.171.51:800
# 101.200.141.114:80
# 101.200.143.168:80
# 101.200.169.110:80
# 101.201.235.141:8000
# 101.231.213.218:8080
# 101.255.60.126:80
# 101.255.64.210:80
# 101.255.76.50:80
# 101.69.178.145:7777
# 101.71.90.182:80
# 101.71.90.183:80
# 103.13.133.198:8080
# 103.18.4.13:9000
# 103.205.24.1:8080
# 103.214.172.104:8080
# 103.214.172.158:8080
# 103.214.172.188:8080
# 103.214.172.94:8080
# 103.214.173.134:8080
# 103.214.173.182:8080
# 103.214.173.240:8080
# 103.214.173.90:8080
# 103.214.174.99:8080
# 103.214.175.128:8080
# 103.214.175.203:8080
# 103.214.175.31:8080
# 103.214.175.43:8080
# 103.215.223.27:8080
# 103.218.241.57:3128
# 103.224.118.191:80
# 103.228.246.23:8080
# 103.230.121.213:8080
# 103.235.67.218:8080
# 103.24.99.20:8080
# 103.242.45.68:8080
# 103.246.226.216:8080
# 103.252.194.100:8080
# 103.31.250.164:8080
# 103.39.110.28:808
# 103.4.237.232:8080
# 103.4.66.251:8080
# 103.47.14.54:8080
# 103.55.36.22:8080
# 103.59.59.180:808
# 103.63.158.130:3128
# 104.130.198.147:3128
# 104.131.139.203:8080
# 104.131.75.65:80
# 104.155.219.38:80
# 104.236.90.3:8118
# 104.247.206.243:3128
# 104.247.206.92:3128
# 105.101.254.156:8080
# 106.0.168.238:8080
# 106.119.99.199:8118
# 106.185.39.120:3128
# 106.186.22.65:8888
# 106.39.160.121:80
# 106.75.128.89:80
# 106.75.128.90:80
# 107.170.213.149:3128
# 107.170.77.232:3128
# 107.170.87.231:80
# 107.178.4.109:8080
# 109.104.165.213:8080
# 109.185.200.218:3128
# 109.188.77.154:8081
# 109.188.95.136:8081
# 109.196.127.35:8888
# 109.69.2.125:8080
# 109.72.192.26:8080
# 110.172.142.99:8080
# 110.175.11.234:3128
# 110.34.34.172:8080
# 110.45.70.111:8080
# 111.1.23.130:80
# 111.1.23.131:80
# 111.1.23.141:80
# 111.1.23.143:80
# 111.1.23.146:80
# 111.1.23.162:80
# 111.1.23.173:80
# 111.1.23.179:80
# 111.1.23.182:80
# 111.1.23.187:80
# 111.1.23.189:80
# 111.1.23.190:8088
# 111.11.122.7:80
# 111.118.150.4:8080
# 111.13.136.46:80
# 111.179.75.93:808
# 111.180.200.206:8000
# 111.193.51.30:8000
# 111.206.81.248:80
# 111.221.182.211:80
# 111.225.32.222:81
# 111.23.4.138:80
# 111.23.4.138:8000
# 111.23.4.138:8080
# 111.23.4.139:80
# 111.23.4.139:8000
# 111.23.4.139:8080
# 111.23.4.155:80
# 111.23.4.155:8000
# 111.23.4.155:8080
# 111.23.6.133:80
# 111.23.6.135:80
# 111.23.6.136:80
# 111.23.6.140:80
# 111.23.6.141:80
# 111.23.6.143:80
# 111.23.6.147:80
# 111.23.6.152:80
# 111.23.6.155:80
# 111.23.6.160:80
# 111.23.6.164:80
# 111.23.6.166:80
# 111.243.236.98:8088
# 111.249.36.117:80
# 111.250.102.16:8080
# 111.250.103.143:8080
# 111.250.104.108:8080
# 111.250.106.29:8080
# 111.250.107.61:8080
# 111.250.108.105:8080
# 111.250.108.58:8080
# 111.250.108.65:8080
# 111.250.109.126:8080
# 111.250.109.206:8080
# 111.250.109.208:8080
# 111.250.109.218:8080
# 111.250.109.228:8080
# 111.250.109.230:8080
# 111.250.109.240:8080
# 111.250.109.26:8080
# 111.250.109.81:8080
# 111.250.109.82:8080
# 111.250.110.12:8080
# 111.250.110.127:8080
# 111.250.110.136:8080
# 111.250.110.190:8080
# 111.250.110.241:8080
# 111.250.111.11:8080
# 111.250.111.195:8080
# 111.250.111.218:8080
# 111.250.111.239:8080
# 111.250.111.250:8080
# 111.250.111.3:8080
# 111.250.111.53:8080
# 111.250.111.70:8080
# 111.250.42.55:8080
# 111.250.43.89:8080
# 111.250.47.198:8080
# 111.250.99.63:8080
# 111.7.162.18:8080
# 111.7.162.18:8088
# 111.7.162.18:8089
# 111.7.162.18:90
# 111.7.162.19:8080
# 111.7.162.19:8088
# 111.7.162.19:8089
# 111.7.162.19:90
# 111.7.162.20:8080
# 111.7.162.20:8088
# 111.7.162.21:8080
# 111.7.162.21:8088
# 111.7.162.21:8089
# 111.7.162.22:8080
# 111.7.162.22:8088
# 111.7.162.22:8089
# 111.7.162.23:8080
# 111.7.162.23:8088
# 111.7.162.23:8089
# 111.7.162.23:90
# 111.7.162.25:8080
# 111.7.162.25:8088
# 111.7.162.25:8089
# 111.7.162.29:8080
# 111.7.162.33:8080
# 111.7.162.36:8080
# 111.7.162.37:8080
# 111.7.162.38:8080
# 111.7.162.43:8080
# 111.7.162.43:8088
# 111.7.162.43:8089
# 111.7.162.44:8080
# 111.7.162.44:8088
# 111.7.162.44:8089
# 111.7.162.45:8080
# 111.7.162.45:8088
# 111.7.162.45:8089
# 111.7.162.46:8080
# 111.7.162.46:8088
# 111.7.162.46:8089
# 111.7.162.46:90
# 111.7.162.47:8080
# 111.7.162.47:8088
# 111.7.162.47:8089
# 111.7.162.48:8080
# 111.7.162.48:8088
# 111.7.162.48:8089
# 111.7.162.48:90
# 111.7.162.49:8080
# 111.7.162.49:8088
# 111.7.162.49:8089
# 111.7.162.49:90
# 111.7.162.50:8080
# 111.7.162.50:8088
# 111.7.162.50:8089
# 111.7.162.50:90
# 111.7.162.55:8080
# 111.7.162.57:8080
# 111.7.162.58:8080
# 111.7.162.59:8080
# 111.7.162.61:8080
# 111.7.162.62:8080
# 111.7.162.65:8080
# 111.7.162.74:8080
# 111.90.179.42:8080
# 111.90.189.118:8080
# 111.93.59.250:3128
# 112.104.17.60:8088
# 112.11.208.43:8888
# 112.112.70.115:80
# 112.112.70.116:80
# 112.112.70.118:80
# 112.195.71.86:8118
# 112.214.73.253:80
# 112.228.38.33:8888
# 112.236.38.158:8888
# 112.243.184.242:8888
# 112.29.141.122:80
# 112.29.141.131:8088
# 112.29.141.141:8088
# 112.29.141.142:80
# 112.29.141.142:8080
# 112.29.141.241:80
# 112.29.141.241:8088
# 112.29.141.242:8080
# 112.29.141.242:8088
# 112.29.141.243:8080
# 112.29.141.243:8088
# 112.29.141.81:8088
# 112.29.141.83:8080
# 112.29.141.83:8088
# 112.29.141.84:80
# 112.29.141.84:8088
# 112.29.141.88:8088
# 112.29.141.89:8088
# 112.29.141.90:80
# 112.54.3.4:8080
# 113.107.112.210:8101
# 113.108.197.234:80
# 113.161.68.146:8080
# 113.185.19.192:80
# 113.185.19.233:80
# 113.195.108.16:8888
# 113.206.120.164:8080
# 113.249.168.101:808
# 113.252.236.96:8080
# 113.254.71.224:8088
# 113.255.210.67:80
# 113.255.49.49:80
# 113.31.27.228:8080
# 114.215.150.13:3128
# 114.215.209.143:9999
# 114.227.4.91:808
# 114.24.65.49:8080
# 114.26.152.177:8080
# 114.26.153.241:8080
# 114.26.155.39:8080
# 114.26.157.220:8080
# 114.26.160.248:8080
# 114.26.163.88:8080
# 114.26.169.169:8080
# 114.26.169.235:8080
# 114.26.170.146:8080
# 114.26.171.94:8080
# 114.26.175.172:8080
# 114.26.175.219:8080
# 114.40.58.216:8088
# 114.40.98.245:8088
# 114.41.115.230:8088
# 114.41.91.108:8088
# 114.44.231.132:8080
# 114.45.192.161:8080
# 114.45.192.96:8080
# 114.45.193.165:8080
# 114.45.193.220:8080
# 114.45.193.69:8080
# 114.45.194.239:8080
# 114.45.194.78:8080
# 114.45.207.82:8998
# 114.46.240.31:8998
# 115.112.106.146:8080
# 115.112.106.147:8080
# 115.112.106.149:8080
# 115.124.73.122:80
# 115.159.185.186:8088
# 115.201.140.235:8888
# 115.217.248.74:8888
# 115.231.94.34:7777
# 115.236.75.201:80
# 115.238.154.11:80
# 115.238.154.12:80
# 115.28.101.22:3128
# 115.28.170.44:8099
# 115.28.188.178:8888
# 115.84.179.131:80
# 116.214.32.51:8080
# 116.24.92.127:3128
# 116.247.110.116:3128
# 116.50.76.54:80
# 116.50.76.54:8080
# 117.102.127.186:8080
# 117.102.71.234:8080
# 117.103.173.98:80
# 117.158.168.213:9000
# 117.16.46.63:3128
# 117.169.4.43:843
# 117.239.196.27:8080
# 117.36.197.152:3128
# 118.144.151.145:3128
# 118.144.154.253:3128
# 118.144.156.2:3128
# 118.144.213.89:3128
# 118.151.209.114:80
# 118.161.45.156:80
# 118.161.74.76:8888
# 118.163.235.36:8088
# 118.165.112.106:8080
# 118.165.112.112:8080
# 118.165.112.231:8080
# 118.165.112.233:8080
# 118.165.112.4:8080
# 118.165.112.58:8080
# 118.165.113.160:8080
# 118.165.113.196:8080
# 118.165.113.75:8080
# 118.165.114.6:8080
# 118.165.114.64:8080
# 118.165.29.193:8080
# 118.165.30.221:8080
# 118.165.75.105:8080
# 118.165.75.14:8080
# 118.165.75.190:8080
# 118.165.75.49:8080
# 118.165.76.208:8080
# 118.165.76.243:8080
# 118.165.77.38:8080
# 118.165.77.88:8080
# 118.165.78.169:8080
# 118.165.78.248:8080
# 118.165.79.10:8080
# 118.165.79.15:8080
# 118.165.79.155:8080
# 118.165.79.182:8080
# 118.165.79.206:8080
# 118.168.71.78:8080
# 118.168.74.21:8080
# 118.168.75.191:8080
# 118.168.78.115:8080
# 118.170.214.13:8088
# 118.175.2.186:3128
# 118.187.10.10:80
# 118.187.10.19:80
# 118.187.10.9:80
# 118.189.157.9:3128
# 118.244.68.21:80
# 118.69.202.160:3128
# 118.96.138.7:8080
# 118.97.188.117:3128
# 119.114.17.62:808
# 119.116.76.37:808
# 119.246.199.142:3128
# 119.252.172.133:3128
# 119.29.1.26:80
# 119.29.103.13:8888
# 119.29.119.49:80
# 119.29.232.113:3128
# 119.29.253.167:8888
# 119.36.145.76:8088
# 119.53.121.203:8118
# 119.6.136.122:80
# 119.6.136.122:843
# 119.80.56.76:8080
# 119.81.189.194:25
# 119.81.189.194:80
# 119.81.189.194:8080
# 119.81.189.194:8123
# 119.81.71.27:80
# 119.81.71.27:8080
# 119.81.71.27:8123
# 119.90.62.104:80
# 119.90.62.104:8080
# 119.90.62.104:9999
# 120.132.71.212:80
# 120.204.85.29:3128
# 120.237.103.114:8080
# 120.24.228.160:3128
# 120.24.73.165:3128
# 120.24.86.201:3128
# 120.25.235.11:8089
# 120.26.88.146:3128
# 120.37.187.41:8000
# 120.52.72.21:80
# 120.52.72.21:9011
# 120.52.72.23:80
# 120.52.72.23:9011
# 120.52.72.48:80
# 120.52.72.48:9011
# 120.52.72.52:80
# 120.52.72.52:9011
# 120.52.72.53:80
# 120.52.72.54:80
# 120.52.72.56:80
# 120.52.72.58:80
# 120.52.72.59:80
# 120.52.72.67:80
# 120.52.73.109:100
# 120.52.73.109:80
# 120.52.73.109:8080
# 120.52.73.109:8081
# 120.52.73.109:8082
# 120.52.73.109:8083
# 120.52.73.109:8087
# 120.52.73.109:8088
# 120.52.73.109:8090
# 120.52.73.109:8092
# 120.52.73.109:8093
# 120.52.73.109:90
# 120.52.73.112:80
# 120.52.73.112:8080
# 120.52.73.112:8082
# 120.52.73.112:8087
# 120.52.73.112:8089
# 120.52.73.112:8090
# 120.52.73.112:8092
# 120.52.73.123:100
# 120.52.73.123:80
# 120.52.73.123:8080
# 120.52.73.123:8081
# 120.52.73.123:8082
# 120.52.73.123:8086
# 120.52.73.123:8087
# 120.52.73.123:8090
# 120.52.73.123:8092
# 120.52.73.133:80
# 120.52.73.133:8080
# 120.52.73.133:8081
# 120.52.73.133:8082
# 120.52.73.133:8089
# 120.52.73.133:90
# 120.52.73.146:100
# 120.52.73.146:80
# 120.52.73.146:8080
# 120.52.73.146:8083
# 120.52.73.146:8089
# 120.52.73.146:8090
# 120.52.73.146:8094
# 120.52.73.146:90
# 120.52.73.175:80
# 120.52.73.97:100
# 120.52.73.97:80
# 120.52.73.97:8080
# 120.52.73.97:8081
# 120.52.73.97:8085
# 120.52.73.97:8086
# 120.52.73.97:8087
# 120.52.73.97:8088
# 120.52.73.97:8089
# 120.52.73.97:8090
# 120.52.73.97:8091
# 120.52.73.97:81
# 120.52.73.97:82
# 120.52.73.97:83
# 120.52.73.97:84
# 120.52.73.97:85
# 120.52.73.97:86
# 120.52.73.97:87
# 120.52.73.97:88
# 120.52.73.97:89
# 120.52.73.97:90
# 120.52.73.97:91
# 120.52.73.97:92
# 120.52.73.97:93
# 120.52.73.97:94
# 120.52.73.97:95
# 120.52.73.97:98
# 120.55.180.55:80
# 120.55.245.47:80
# 120.76.203.31:80
# 120.76.243.40:80
# 120.90.6.92:8080
# 121.10.234.15:3128
# 121.140.126.250:3128
# 121.17.18.149:3128
# 121.183.4.54:51325
# 121.193.143.249:80
# 121.199.7.118:8338
# 121.203.211.18:80
# 121.40.160.216:83
# 121.40.203.107:80
# 121.40.203.107:8088
# 121.41.0.141:80
# 122.0.74.166:3389
# 122.147.99.162:8088
# 122.193.14.106:80
# 122.193.14.106:82
# 122.193.14.106:83
# 122.195.153.180:8888
# 122.226.152.2:3128
# 122.226.203.70:3128
# 122.226.62.90:3128
# 122.233.158.9:808
# 122.5.243.116:8888
# 122.52.123.15:8080
# 122.52.133.5:8080
# 122.53.51.95:8080
# 122.96.59.104:80
# 122.96.59.104:81
# 122.96.59.104:82
# 122.96.59.104:843
# 122.96.59.106:81
# 122.96.59.106:82
# 122.96.59.106:83
# 123.125.122.203:80
# 123.125.122.204:80
# 123.125.122.205:80
# 123.125.122.224:80
# 123.139.56.234:9999
# 123.176.102.77:8080
# 123.194.15.85:80
# 123.206.195.147:80
# 123.232.211.18:8888
# 123.30.238.16:3128
# 123.30.75.115:3128
# 123.30.75.115:443
# 123.30.75.115:80
# 123.56.28.196:8888
# 123.59.153.102:8000
# 123.65.217.151:9797
# 123.7.14.140:3128
# 123.7.82.20:3128
# 124.132.35.74:8080
# 124.133.230.254:80
# 124.155.112.85:80
# 124.192.134.243:3128
# 124.192.221.240:3128
# 124.192.252.165:3128
# 124.193.27.253:3128
# 124.193.29.8:3128
# 124.193.58.10:3128
# 124.193.7.247:3128
# 124.206.111.158:3128
# 124.206.186.161:3128
# 124.206.209.244:3128
# 124.207.132.242:3128
# 124.207.186.154:3128
# 124.244.157.209:80
# 124.248.177.180:8080
# 124.250.236.26:80
# 124.255.23.82:80
# 124.32.141.184:3128
# 124.88.67.17:843
# 124.88.67.20:843
# 124.88.67.23:843
# 124.88.67.24:843
# 124.88.67.31:80
# 124.88.67.31:843
# 124.88.67.32:80
# 124.88.67.32:81
# 124.88.67.32:83
# 124.88.67.32:843
# 125.109.83.78:8888
# 125.162.140.49:80
# 125.166.221.140:3128
# 125.253.101.44:8080
# 125.253.32.158:3128
# 125.26.106.98:8080
# 125.77.141.11:8088
# 125.94.112.165:8998
# 128.199.113.157:443
# 128.199.115.225:3128
# 128.199.115.31:3128
# 128.199.132.114:8080
# 128.199.166.246:8080
# 128.199.167.7:8080
# 128.199.178.73:8080
# 128.199.209.118:808
# 128.199.216.35:8080
# 128.199.65.24:80
# 128.199.65.24:8080
# 128.199.65.44:8080
# 128.199.89.163:3128
# 128.199.91.174:8080
# 128.199.95.69:3128
# 13.66.59.3:80
# 13.67.211.33:3128
# 13.90.209.54:3128
# 130.14.29.110:80
# 130.14.29.120:80
# 137.135.166.225:8124
# 137.135.166.225:8128
# 137.135.166.225:8129
# 137.135.166.225:8130
# 137.135.166.225:8139
# 137.135.166.225:8141
# 137.135.166.225:8143
# 137.135.166.225:8144
# 137.135.166.225:8145
# 137.74.254.198:3128
# 138.0.102.218:3128
# 138.186.19.22:80
# 138.201.4.99:3128
# 138.204.114.218:8080
# 138.59.247.3:8080
# 138.68.140.197:3128
# 138.68.30.235:8088
# 138.68.41.93:8080
# 139.129.117.111:3128
# 139.196.51.232:3128
# 139.217.12.225:80
# 139.217.29.113:8088
# 139.224.41.172:8080
# 139.59.178.67:8080
# 139.59.249.168:8080
# 139.59.251.44:80
# 139.82.188.30:8080
# 14.139.120.253:8080
# 14.139.213.179:3128
# 14.139.213.183:3128
# 14.156.126.114:8888
# 14.29.124.51:80
# 14.29.124.52:80
# 14.29.124.53:80
# 14.36.4.200:3128
# 142.54.164.106:3721
# 143.160.210.41:80
# 146.0.73.14:80
# 149.202.195.236:80
# 149.202.49.42:80
# 149.56.97.176:3128
# 150.129.179.154:8080
# 150.129.4.18:8080
# 151.243.144.84:8080
# 151.58.51.40:8085
# 152.160.35.171:80
# 152.8.244.29:8080
# 154.64.209.238:8081
# 154.72.48.214:8080
# 157.7.220.63:80
# 157.7.223.209:80
# 159.203.75.49:3128
# 159.253.80.30:808
# 159.255.163.189:80
# 159.8.114.37:25
# 159.8.114.37:80
# 159.8.114.37:8080
# 159.8.114.37:8123
# 161.202.226.194:80
# 161.202.226.194:8080
# 161.202.226.194:8123
# 162.223.88.243:80
# 162.243.37.237:8080
# 162.243.47.142:3128
# 162.243.59.161:3128
# 163.172.12.246:80
# 164.132.28.153:3128
# 164.132.28.157:3128
# 165.193.231.226:3128
# 168.1.47.248:8080
# 168.205.92.11:3128
# 168.63.20.19:8123
# 168.63.20.19:8125
# 168.63.20.19:8127
# 168.63.20.19:8128
# 168.63.20.19:8132
# 168.63.24.174:8136
# 168.63.24.174:8137
# 168.63.24.174:8138
# 169.50.87.252:80
# 169.57.1.84:25
# 169.57.1.84:80
# 169.57.1.84:8080
# 169.57.1.84:8123
# 169.57.157.148:25
# 169.57.157.148:80
# 169.57.157.148:8080
# 169.57.157.148:8123
# 171.100.123.76:3128
# 171.255.48.5:3128
# 173.192.128.238:25
# 173.192.128.238:80
# 173.192.128.238:8080
# 173.192.128.238:8123
# 173.192.21.89:25
# 173.192.21.89:80
# 173.192.21.89:8080
# 173.192.21.89:8123
# 173.201.183.172:8000
# 173.226.174.40:3128
# 173.68.185.170:80
# 175.153.18.50:8118
# 175.153.88.116:808
# 175.180.198.39:808
# 175.180.199.188:808
# 175.180.76.54:808
# 175.180.78.200:808
# 175.181.97.116:8998
# 175.182.114.16:8998
# 175.182.118.228:8080
# 175.182.139.112:8080
# 175.182.139.90:8080
# 175.182.142.252:8080
# 175.25.30.23:8080
# 176.107.242.142:8080
# 176.12.125.198:8080
# 176.123.129.14:8080
# 176.194.189.56:8080
# 176.31.96.198:3128
# 176.31.96.198:8080
# 176.34.225.229:80
# 176.97.190.63:8080
# 177.0.81.8:80
# 177.103.182.12:3128
# 177.104.244.130:8080
# 177.11.162.78:8080
# 177.124.103.246:8080
# 177.125.8.154:3128
# 177.126.81.50:3128
# 177.152.174.141:8080
# 177.207.234.14:80
# 177.207.245.37:3128
# 177.220.130.58:3128
# 177.220.156.60:3128
# 177.246.98.211:8080
# 177.35.109.35:3128
# 177.39.186.59:8008
# 177.44.191.202:8080
# 177.5.219.112:8080
# 177.71.17.70:8080
# 177.75.236.17:8080
# 177.8.163.66:3128
# 177.8.181.153:8082
# 177.87.241.226:8080
# 177.92.249.44:80
# 177.93.255.126:8080
# 178.151.69.119:3128
# 178.158.140.212:8080
# 178.159.216.159:3128
# 178.166.41.225:80
# 178.22.148.122:3129
# 178.236.129.5:8080
# 178.251.213.215:8083
# 178.32.153.219:80
# 178.32.87.230:3128
# 178.62.123.240:8118
# 178.62.124.132:8118
# 178.62.195.131:8080
# 178.62.2.78:3128
# 179.110.221.42:8888
# 179.178.48.161:808
# 179.185.89.225:80
# 179.217.26.134:3128
# 179.220.228.204:3128
# 180.107.26.237:808
# 180.123.84.140:8118
# 180.148.211.203:8080
# 180.150.111.251:80
# 180.152.48.7:9529
# 180.169.8.51:3128
# 180.183.247.160:8080
# 180.234.217.27:8080
# 180.235.133.27:8080
# 180.244.57.176:3128
# 180.250.174.250:8080
# 180.250.207.162:8080
# 180.250.32.66:80
# 180.254.190.11:8888
# 181.118.126.161:8080
# 181.143.51.106:8080
# 181.211.191.227:8080
# 181.40.78.174:3128
# 181.41.219.69:9999
# 181.48.0.173:8081
# 181.62.252.85:8081
# 181.64.115.150:8080
# 182.132.233.229:8118
# 182.176.121.167:80
# 182.176.121.167:8080
# 182.203.241.43:8888
# 182.225.165.184:3128
# 182.243.124.216:3128
# 182.253.223.140:8080
# 182.253.236.74:8080
# 182.253.26.196:8080
# 182.34.180.49:8118
# 182.36.184.115:8888
# 182.52.104.63:8080
# 182.52.49.34:8080
# 182.74.91.45:8080
# 182.90.23.3:8888
# 182.93.232.38:8080
# 183.129.178.14:8080
# 183.157.188.244:8123
# 183.196.242.197:3128
# 183.232.35.236:8080
# 183.245.146.62:80
# 183.245.147.15:8080
# 183.57.17.194:8081
# 183.57.82.74:8081
# 183.61.236.53:3128
# 183.61.236.54:3128
# 183.61.236.55:3128
# 183.62.206.210:3128
# 183.62.58.250:9797
# 183.63.90.197:808
# 183.83.9.74:8080
# 183.88.38.247:8080
# 183.93.20.206:8888
# 184.173.139.10:80
# 184.49.233.234:8080
# 185.10.17.76:80
# 185.101.238.5:8080
# 185.114.234.21:80
# 185.128.126.163:8080
# 185.13.228.124:8080
# 185.138.112.1:8080
# 185.140.230.67:3128
# 185.143.40.50:8080
# 185.28.193.95:8080
# 185.31.218.42:8080
# 185.35.103.145:8080
# 185.42.60.175:3128
# 185.5.97.75:8080
# 185.52.77.26:8080
# 185.82.223.106:3128
# 185.93.68.53:3128
# 185.97.123.209:8888
# 185.97.123.211:8888
# 186.0.225.106:8081
# 186.10.5.138:8080
# 186.10.5.139:8080
# 186.10.5.140:8080
# 186.10.5.141:8080
# 186.103.193.51:8080
# 186.103.201.74:8080
# 186.208.231.31:8080
# 186.226.43.158:8080
# 186.229.144.146:8080
# 186.229.51.42:80
# 186.249.2.138:80
# 186.251.164.250:8080
# 186.42.121.90:3128
# 186.67.158.43:3128
# 186.85.85.102:80
# 186.89.151.208:8080
# 186.90.70.31:3128
# 186.92.245.28:8090
# 186.93.126.204:8080
# 187.120.181.172:8080
# 187.141.47.161:3128
# 187.180.17.75:3128
# 187.32.25.193:3128
# 187.33.229.99:8080
# 187.33.82.94:8080
# 187.44.1.167:8080
# 187.44.1.54:8080
# 187.49.92.34:6006
# 187.6.252.146:3128
# 187.60.219.248:3128
# 187.86.137.222:3128
# 187.95.116.10:3128
# 188.136.133.42:80
# 188.170.209.50:3128
# 188.172.194.231:8080
# 188.211.239.17:3128
# 188.213.174.31:3128
# 188.231.149.119:8080
# 188.38.105.43:8080
# 189.124.25.90:3128
# 189.202.187.68:3128
# 189.202.220.192:80
# 189.202.220.197:80
# 189.202.220.199:80
# 189.3.168.114:3128
# 189.38.251.223:8080
# 190.0.35.6:3128
# 190.104.233.24:8080
# 190.14.248.82:8080
# 190.140.150.68:3128
# 190.144.241.197:3128
# 190.146.21.123:8080
# 190.15.222.55:8080
# 190.151.10.226:8080
# 190.18.134.27:8080
# 190.199.144.99:3128
# 190.214.48.125:8080
# 190.245.120.168:8080
# 190.248.135.134:8080
# 190.39.141.44:3128
# 190.42.36.150:8080
# 190.74.23.129:8080
# 190.78.30.143:8090
# 190.95.214.148:8080
# 191.102.87.242:3128
# 191.102.89.10:3128
# 191.102.89.54:3128
# 191.242.76.4:8088
# 191.252.1.154:80
# 192.140.223.94:8080
# 192.151.147.178:3128
# 192.159.123.154:8080
# 192.241.198.204:80
# 192.25.162.193:80
# 192.95.22.7:3128
# 192.95.22.7:8080
# 192.95.57.170:8080
# 192.95.57.175:8080
# 192.99.246.101:8118
# 193.194.69.36:3128
# 193.200.83.243:8080
# 193.232.184.141:8080
# 193.93.216.95:8080
# 194.85.37.90:3128
# 195.113.196.29:80
# 195.116.7.10:8080
# 195.117.83.17:8088
# 195.138.86.164:3128
# 195.14.105.96:8080
# 195.14.105.97:8080
# 195.154.54.223:8080
# 195.158.139.46:3128
# 195.158.139.46:8000
# 195.226.178.150:80
# 195.239.244.78:3128
# 195.5.109.243:8080
# 195.60.114.1:80
# 195.62.187.180:80
# 195.72.102.137:80
# 195.9.6.50:8080
# 196.188.0.227:8080
# 196.41.123.151:80
# 197.149.179.181:8888
# 197.210.185.26:8080
# 197.215.220.254:8080
# 197.249.165.55:80
# 198.2.202.54:8090
# 198.211.118.234:8080
# 198.50.211.54:80
# 198.58.120.206:80
# 199.255.95.37:8080
# 199.68.113.193:8080
# 2.179.200.10:8888
# 2.185.99.1:8080
# 200.108.138.118:3128
# 200.11.138.66:8080
# 200.124.231.53:8080
# 200.150.68.126:3128
# 200.167.191.227:9090
# 200.175.157.204:8080
# 200.241.72.226:8080
# 200.249.176.7:80
# 200.255.122.170:8080
# 200.255.220.211:8080
# 200.29.191.149:3128
# 200.46.86.66:3128
# 200.54.180.226:80
# 200.56.200.38:3128
# 200.68.27.100:3128
# 200.76.251.166:3128
# 200.77.139.187:8080
# 200.85.37.254:80
# 200.87.139.101:8080
# 200.87.204.186:8080
# 201.16.175.97:3128
# 201.199.135.100:3128
# 201.20.93.54:8080
# 201.209.13.85:8080
# 201.241.88.63:80
# 201.249.201.105:8089
# 201.33.206.229:3128
# 201.48.34.200:3128
# 201.62.66.79:8080
# 201.7.216.85:3128
# 202.106.16.36:3128
# 202.107.238.51:3128
# 202.108.2.42:80
# 202.118.8.13:3128
# 202.137.25.53:3128
# 202.142.178.106:8080
# 202.142.186.202:8080
# 202.147.244.174:80
# 202.148.4.26:8080
# 202.152.39.66:8080
# 202.169.43.26:8080
# 202.171.253.72:80
# 202.182.51.138:80
# 202.21.116.13:3128
# 202.29.221.102:8080
# 202.43.190.11:8118
# 202.69.38.82:8080
# 202.70.86.249:8080
# 202.83.162.218:8080
# 203.130.194.149:3128
# 203.143.20.249:8080
# 203.151.166.69:3128
# 203.154.255.195:3128
# 203.172.240.65:8080
# 203.88.166.141:3128
# 203.91.121.74:3128
# 204.196.190.132:3128
# 205.237.163.78:80
# 208.40.165.200:80
# 208.47.176.252:80
# 208.89.215.206:3128
# 209.159.148.180:8888
# 209.87.244.145:80
# 210.91.41.60:3128
# 210.91.48.121:3128
# 210.91.48.122:3128
# 210.91.48.123:3128
# 211.103.148.66:3128
# 211.110.127.210:3128
# 211.138.151.121:81
# 211.142.195.47:8000
# 211.142.195.47:8080
# 211.142.195.48:8080
# 211.142.195.49:8080
# 211.142.195.49:8088
# 211.142.195.49:8089
# 211.142.195.50:8080
# 211.142.195.50:8088
# 211.142.195.50:8089
# 211.142.195.68:80
# 211.142.195.68:8080
# 211.142.195.68:8090
# 211.142.195.69:80
# 211.143.45.216:3128
# 211.153.17.151:80
# 212.1.227.182:80
# 212.106.4.68:3128
# 212.158.161.241:80
# 212.166.53.168:80
# 212.175.249.171:80
# 212.185.87.53:443
# 212.248.78.171:8080
# 212.33.229.53:8080
# 212.34.54.84:4444
# 212.72.141.18:8080
# 212.91.189.166:8000
# 213.136.65.138:3128
# 213.136.79.122:80
# 213.160.168.43:8080
# 213.165.155.189:80
# 213.221.56.213:3128
# 213.24.60.52:8080
# 213.27.152.15:3128
# 213.57.89.62:18000
# 213.57.89.97:18000
# 213.57.90.10:18000
# 213.80.192.227:8080
# 216.224.172.139:3128
# 217.119.125.102:8081
# 217.12.121.86:80
# 217.128.175.129:80
# 217.23.3.185:3128
# 217.61.1.166:3128
# 217.66.212.203:8080
# 218.102.23.83:8080
# 218.110.253.16:80
# 218.15.254.190:3128
# 218.15.32.43:3128
# 218.17.252.34:3128
# 218.191.25.9:8380
# 218.205.80.12:80
# 218.205.80.13:80
# 218.205.80.2:80
# 218.205.80.3:80
# 218.205.80.4:80
# 218.205.80.8:80
# 218.28.218.193:3128
# 218.28.218.21:3128
# 218.32.94.77:8080
# 218.56.132.158:8080
# 218.59.233.162:3128
# 218.72.175.187:8888
# 218.75.10.171:3128
# 218.75.223.144:3128
# 218.76.106.78:3128
# 218.77.83.89:3128
# 218.90.174.167:3128
# 219.129.164.122:3128
# 219.138.139.174:8000
# 219.141.225.107:80
# 219.141.225.149:80
# 219.142.234.13:8888
# 219.145.218.18:3128
# 219.238.55.124:3128
# 219.239.68.246:3128
# 219.255.197.90:3128
# 219.65.81.124:80
# 219.78.213.179:3128
# 219.82.7.89:8888
# 220.120.119.90:3128
# 220.130.196.155:80
# 220.130.196.155:8080
# 220.136.18.241:8080
# 220.136.20.160:8080
# 220.136.20.238:8080
# 220.137.156.16:8080
# 220.137.157.144:8080
# 220.137.40.128:8080
# 220.137.40.164:8080
# 220.137.40.40:8080
# 220.137.41.252:8080
# 220.137.42.191:8080
# 220.137.43.227:8080
# 220.137.43.32:8080
# 220.137.47.85:8080
# 220.141.158.179:8080
# 220.141.159.241:8080
# 220.141.159.73:8080
# 220.141.162.228:8080
# 220.141.163.194:8080
# 220.161.218.94:3128
# 220.176.211.119:3128
# 220.184.222.52:8118
# 220.225.245.109:8000
# 220.225.87.129:8080
# 220.246.31.179:80
# 220.248.229.45:3128
# 220.248.230.217:3128
# 221.130.13.238:80
# 221.130.13.238:8080
# 221.130.13.238:81
# 221.130.13.238:9999
# 221.180.160.113:80
# 221.181.207.4:80
# 221.195.55.182:8080
# 221.199.203.106:3128
# 221.204.177.57:1920
# 221.211.110.34:3128
# 221.212.221.194:3128
# 221.213.44.5:3128
# 221.221.179.210:3128
# 221.226.82.130:8998
# 221.229.204.231:8080
# 221.237.154.57:9797
# 222.124.177.148:80
# 222.124.34.189:8080
# 222.160.102.183:3128
# 222.165.135.198:3128
# 222.252.17.181:3128
# 222.33.192.238:8118
# 222.45.233.2:3128
# 223.16.231.135:8080
# 223.223.138.212:8080
# 223.27.152.134:8080
# 223.65.148.151:8118
# 223.67.136.218:80
# 223.68.1.38:8000
# 223.78.86.156:8118
# 223.99.254.99:80
# 223.99.254.99:8080
# 24.211.45.254:8080
# 24.213.32.118:8080
# 27.111.44.67:80
# 27.123.4.10:8080
# 27.151.220.118:8888
# 27.194.230.14:8888
# 27.202.49.74:9999
# 27.204.121.207:8000
# 27.54.173.36:808
# 27.8.63.192:8888
# 31.131.67.76:8080
# 31.163.192.38:3128
# 31.186.25.157:3128
# 31.193.140.138:80
# 31.199.181.130:8080
# 36.224.104.246:8080
# 36.224.107.91:8080
# 36.224.110.136:8080
# 36.224.110.16:8080
# 36.224.111.163:8080
# 36.224.111.5:8080
# 36.225.94.235:8080
# 36.225.95.198:8080
# 36.225.95.226:8080
# 36.230.142.163:3128
# 36.230.45.179:3128
# 36.250.159.213:8000
# 36.37.81.130:8080
# 36.37.89.3:8080
# 36.71.148.17:3128
# 36.73.62.125:80
# 36.80.85.147:8080
# 36.81.0.138:8080
# 36.81.1.41:8080
# 36.81.191.217:3128
# 36.81.203.228:8080
# 36.81.253.196:3128
# 36.85.236.137:8080
# 37.1.194.167:3128
# 37.191.41.113:8080
# 37.220.8.136:3128
# 37.235.174.174:8081
# 37.235.65.76:8080
# 37.46.83.179:80
# 37.59.29.93:80
# 39.1.37.153:8080
# 39.167.77.70:8000
# 39.184.129.209:8888
# 39.85.121.4:8888
# 40.113.118.174:8129
# 41.0.204.57:3128
# 41.169.16.202:8080
# 41.186.24.69:3128
# 41.188.49.159:8080
# 41.188.56.105:8080
# 41.204.224.158:8080
# 41.204.87.10:8080
# 41.204.87.25:8080
# 41.205.24.116:8080
# 41.207.49.136:8080
# 41.210.160.74:8080
# 41.210.168.14:8080
# 41.220.31.50:8080
# 41.221.77.249:8080
# 41.33.182.195:8080
# 41.38.25.193:3128
# 41.39.38.83:3128
# 41.76.44.76:3128
# 41.79.60.202:8080
# 41.87.164.49:3128
# 43.231.23.101:8080
# 43.243.112.113:3128
# 43.243.112.115:3128
# 43.243.112.122:3128
# 43.243.112.124:3128
# 43.243.112.78:3128
# 45.124.145.174:8080
# 45.32.179.253:80
# 45.33.54.195:80
# 45.33.74.92:8080
# 45.33.79.116:8080
# 45.40.143.57:80
# 45.55.163.113:8080
# 45.55.173.140:8118
# 45.55.74.210:8080
# 45.64.156.204:8080
# 45.65.11.53:3128
# 45.79.140.191:8118
# 46.10.220.64:8080
# 46.101.22.147:8118
# 46.101.36.66:2015
# 46.101.7.133:8118
# 46.105.214.133:3128
# 46.137.173.154:80
# 46.167.210.2:8118
# 46.219.78.221:8081
# 46.228.10.20:3128
# 46.231.117.154:8081
# 46.231.117.154:8087
# 46.231.117.154:90
# 46.231.214.166:8080
# 46.246.42.162:80
# 46.35.188.7:8080
# 46.47.79.242:8080
# 47.88.104.219:80
# 47.88.11.69:8080
# 47.88.12.78:8118
# 47.88.138.190:8080
# 47.88.14.58:3128
# 47.88.189.216:3128
# 47.88.195.233:3128
# 47.89.53.92:3128
# 47.90.21.171:3128
# 47.90.57.248:9999
# 49.1.244.139:3128
# 49.204.165.159:8080
# 49.207.64.65:8080
# 5.105.112.144:8080
# 5.105.60.235:8080
# 5.105.60.235:88
# 5.135.190.199:3128
# 5.135.204.122:3128
# 5.160.87.114:8080




end
