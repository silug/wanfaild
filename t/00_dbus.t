#!/usr/bin/perl

use strict;
use warnings;

use Test::More skip_all => "Unimplemented";

####### Attaching to the bus ###########

BEGIN { use_ok('Net::DBus'); }

# Find the most appropriate bus
#my $bus = Net::DBus->find;

# ... or explicitly go for the session bus
#my $bus = Net::DBus->session;

# .... or explicitly go for the system bus
my $bus = Net::DBus->system;


######## Accessing remote services #########

# Get a handle to the HAL service
my $hal = $bus->get_service("org.freedesktop.Hal");

# Get the device manager
my $manager = $hal->get_object("/org/freedesktop/Hal/Manager", 
                               "org.freedesktop.Hal.Manager");

# List devices
foreach my $dev (@{$manager->GetAllDevices}) {
    print $dev, "\n";
}

__END__

$ dbus-monitor --system
signal sender=org.freedesktop.DBus -> dest=:1.103 serial=2 path=/org/freedesktop/DBus; interface=org.freedesktop.DBus; member=NameAcquired
   string ":1.103"
signal sender=:1.6 -> dest=(null destination) serial=713 path=/org/freedesktop/NetworkManager/Devices/0; interface=org.freedesktop.NetworkManager.Device.Wired; member=PropertiesChanged
   array [
      dict entry(
         string "Carrier"
         variant             boolean false
      )
   ]
signal sender=:1.6 -> dest=(null destination) serial=714 path=/org/freedesktop/NetworkManager/Devices/0; interface=org.freedesktop.NetworkManager.Device.Wired; member=PropertiesChanged
   array [
      dict entry(
         string "Carrier"
         variant             boolean true
      )
   ]

