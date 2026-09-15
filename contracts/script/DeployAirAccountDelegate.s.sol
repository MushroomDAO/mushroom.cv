// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.25;

import {Script, console} from "forge-std/Script.sol";
import {AirAccountDelegate} from "../src/AirAccountDelegate.sol";

/**
 * @notice Deploys AirAccountDelegate to the target chain. No constructor args, no owner.
 *
 *  Once deployed, the address becomes the canonical EIP-7702 delegation target for the
 *  Mycelium gasless purchase flow. **It is immutable** — record the address carefully and
 *  update the spec at docs/gasless-eoa-enhance/00-spec.md.
 *
 *  Run:
 *    forge script script/DeployAirAccountDelegate.s.sol \
 *      --rpc-url $SEPOLIA_RPC_URL2 \
 *      --private-key $PRIVATE_KEY_ANNI \
 *      --broadcast --verify
 */
contract DeployAirAccountDelegate is Script {
    function run() external returns (AirAccountDelegate delegate) {
        console.log("=== Deploying AirAccountDelegate ===");
        console.log("Broadcaster:", msg.sender);

        vm.startBroadcast();
        delegate = new AirAccountDelegate();
        vm.stopBroadcast();

        console.log("AirAccountDelegate deployed at:", address(delegate));
        console.log("");
        console.log("=== Next steps ===");
        console.log("1. Verify on Etherscan (forge verify-contract ... AirAccountDelegate.sol:AirAccountDelegate)");
        console.log("2. Update docs/gasless-eoa-enhance/00-spec.md deployment section with this address");
        console.log("3. Set AIRACCOUNT_DELEGATE env in services/relayer/wrangler.toml");
        console.log("4. Set AIRACCOUNT_DELEGATE_ADDRESS in site/join.html");
    }
}
