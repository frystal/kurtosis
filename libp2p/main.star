# kubo_config = import_module("/home/demo/kurtosis-postgres/config/kubo-config/config.star")

# local_contents = read_file(
#     src = "./kubo-config.txt",
# )
# kubo_config = import_module("github.com/frystal/kurtosis/kubo-config/test.star")
KUBO_CONFIG_FILENAME = "kubo-config"
def run(plan, args):
    # data_package_module_result = kubo_config.run(plan, {})
    # print(data_package_module_result)
    # Add a Lotus server
    kubo_config_data = plan.upload_files("github.com/frystal/kurtosis/libp2p/kubo-config/config")
    postgres = plan.add_service(
        name = "kubo-bin",
        config = ServiceConfig(
            image = "ipfs/kubo:latest",
            ports = {
                "P2P_TCP_QUIC": PortSpec(4001),
                "RPC_API":PortSpec(5001),
                "Gateway":PortSpec(8080),
            },
        ),
    )

    kubo_log_exec_recipe = ExecRecipe(
    command = ["ipfs", "log", "level", "all", "debug"],
    )
    result = plan.exec(
    service_name = "kubo-bin",

    recipe = kubo_log_exec_recipe,
    )
    plan.print(result["output"])
    plan.print(result["code"])
