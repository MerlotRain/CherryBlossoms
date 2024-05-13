const std = @import("std");
const bs = @import("./bitstream.zig");

// 示例用法
const testing = std.testing;

test "bitstream" {
    const allocator = &std.heap.page_allocator;
    var bitstream = try bs.BitStream.init(allocator, 100);
    defer bitstream.deinit();

    // 在这里使用bitstream对象进行操作

    try testing.expect(bitstream.length == 100);
    try testing.expect(bitstream.dataSize == 13);

    // 测试extend接口
    bitstream.length = 200;
    try testing.expectError(error.OutOfMemory, bitstream.extend());
    try testing.expect(bitstream.length == 200);
    try testing.expect(bitstream.dataSize == 26);
}
