package src.NED;

import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.node.contract.INetworkNode;
import inet.physicallayer.wireless.common.contract.packetlevel.IRadioMedium;
import inet.node.inet.ArdusimHost;
import inet.applications.udpapp.Trigger;
import inet.environment.common.PhysicalEnvironment;
import inet.common.geometry.common.OsgGeographicCoordinateSystem;
import inet.physicallayer.wireless.ieee80211.packetlevel.Ieee80211ScalarRadioMedium;
import inet.visualizer.common.IntegratedVisualizer;

network Network
{
    parameters:
        int numUAVs @prompt("Number of clients:") = default(5);
        @display("bgb=137.8,142.56667");
    submodules:
        rt: RealTime {
            @display("p=1500.566668,1500.96667");
        }
        configurator: Ipv4NetworkConfigurator {
            @display("p=1600.566668,1600.866667");
        }
        radioMedium: <default("Ieee80211DimensionalRadioMedium")> like IRadioMedium {
            @display("p=1700.2,1700.100002");
        }
        visualizer: IntegratedVisualizer {
            parameters:
                @display("p=1850.566668,1850.333336");
        }
        physicalEnvironment: PhysicalEnvironment {
            @display("p=1950.566668,1950.5");
        }


        //<default("AdhocHost")> like INetworkNode 
        host[numUAVs]: ArdusimHost {
            @display("p=905.608,919.664;i=misc/drone");
        }
        trig: Trigger {
            @display("p=76.7,68.03333");
            gates:
                out[parent.numUAVs];
        }

    connections allowunconnected:
        for i=0..(numUAVs - 1) {
            trig.out[i] --> host[i].trigger;
        }
}
