#include <modbus.h>
#include <stdio.h>
#include <stdlib.h>

int main() {
    printf("1. create ctx\n");
    modbus_t *ctx = modbus_new_rtu("/dev/pts/2", 9600, 'N', 8, 1);

    modbus_set_slave(ctx, 1);
    printf("2. try connect...\n");

    if (modbus_connect(ctx) == -1) {
        perror("Connection failed");
        modbus_free(ctx);
        return -1;
    }

    printf("3. connected.\n");

    modbus_mapping_t *mb_mapping = modbus_mapping_new(0, 0, 32, 0);
    if (mb_mapping == NULL) {
        fprintf(stderr, "Failed to allocate mapping\n");
        return -1;
    }
    mb_mapping->tab_registers[0] = 11;
    mb_mapping->tab_registers[1] = 22;
    mb_mapping->tab_registers[2] = 33;
    mb_mapping->tab_registers[3] = 44;

    printf("4. enter receive loop...\n");

    while (1) {
        uint8_t query[MODBUS_RTU_MAX_ADU_LENGTH];
        int rc = modbus_receive(ctx, query);
        if (rc > 0) {
            printf("Got query, len=%d\n", rc);
            modbus_reply(ctx, query, rc, mb_mapping);
        }
    }

    modbus_mapping_free(mb_mapping);
    modbus_close(ctx);
    modbus_free(ctx);
    return 0;
}
