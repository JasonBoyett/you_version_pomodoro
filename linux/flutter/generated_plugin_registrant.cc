//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <device_type/device_type_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) device_type_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "DeviceTypePlugin");
  device_type_plugin_register_with_registrar(device_type_registrar);
}
