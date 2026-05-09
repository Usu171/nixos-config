{ config, pkgs, ... }:

{
  services.munge.password = "/var/lib/munge/munge.key";

  services.slurm = {
    server.enable = true;
    client.enable = true;

    clusterName = "localcluster";
    controlMachine = config.networking.hostName;
    nodeName = [
      "${config.networking.hostName} CPUs=16 RealMemory=25600 Sockets=1 CoresPerSocket=8 ThreadsPerCore=2"
    ];
    partitionName = [ "debug Nodes=ALL Default=YES MaxTime=INFINITE State=UP" ];

    stateSaveLocation = "/var/spool/slurm";
    user = "slurm";

    extraConfig = ''
      AuthType=auth/munge
      SchedulerType=sched/backfill
      TaskPlugin=task/none
      SlurmdLogFile=/var/log/slurmd.log
      SlurmctldLogFile=/var/log/slurmctld.log
    '';
  };

  system.activationScripts.mungeKey = {
    deps = [ "users" ];
    text = ''
      ${pkgs.coreutils}/bin/install -d -m 0700 -o munge -g munge /var/lib/munge

      if [ ! -e /var/lib/munge/munge.key ]; then
        ${pkgs.munge}/bin/mungekey --create --keyfile /var/lib/munge/munge.key
      fi

      ${pkgs.coreutils}/bin/chown munge:munge /var/lib/munge/munge.key
      ${pkgs.coreutils}/bin/chmod 0400 /var/lib/munge/munge.key
    '';
  };
}
