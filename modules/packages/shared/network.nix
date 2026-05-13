{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gping
    openssl
    curlie
    httpie
    aria2
    socat
    tcpdump
    ipcalc

    # dns
    dnsutils
    knot-dns
    ldns
    doggo

    # traceroute
    trippy
    nexttrace
    mtr

    iperf

    # file transfer
    rsync
    rclone
    croc

    # scan
    nmap
  ];
}
