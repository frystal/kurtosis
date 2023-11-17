# kubo_config = import_module("/home/demo/kurtosis-postgres/config/kubo-config/config.star")

# local_contents = read_file(
#     src = "./kubo-config.txt",
# )
# kubo_config = import_module("github.com/frystal/kurtosis/kubo-config/test.star")

def run(plan, args):
    kubo_config_data = plan.upload_files("github.com//frystal/kurtosis/libp2p/.../../test1.config", name="kubog")
    kubo = plan.add_service(
        name = "kubo-victim",
        config = ServiceConfig(
            image = "ipfs/kubo:latest",
            ports = {
                "P2P_TCP_QUIC": PortSpec(4001),
                "RPC_API":PortSpec(5001),
                "Gateway":PortSpec(8080),
            },
            files={
                "/root": kubo_config_data,
            },
            env_vars={
                "GOLOG_LOG_LEVEL" : "debug",
                "GOLOG_LOG_FMT" : "json",
                "IPFS_FUSE_DEBUG": "",
                "YAMUX_DEBUG": "",
                "LIBP2P_DEBUG_RCMGR": "",

            }
        ),
    )

    # kubo_log_recipe = ExecRecipe(
    # command = ["ipfs", "log", "level", "all", "debug"],
    # )
    # result = plan.exec(
    # service_name = "kubo-victim",

    # recipe = kubo_log_recipe,
    # )
    

