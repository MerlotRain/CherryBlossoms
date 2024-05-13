// 创建一个bitstream结构体，内部记录allocator对象，length,datasize,data指针
const std = @import("std");
const Allocator = std.mem.Allocator;

pub const BitStream = struct {
    allocator: *const Allocator,
    length: usize,
    dataSize: usize,
    data: []u8,

    pub fn init(allocator: *const Allocator, length: usize) !BitStream {
        const dataSize = (length + 7) / 8;
        const data = try allocator.alloc(u8, dataSize);
        return BitStream{
            .allocator = allocator,
            .length = length,
            .dataSize = dataSize,
            .data = data,
        };
    }

    pub fn deinit(self: *BitStream) void {
        self.allocator.free(self.data);
    }
    // 使用内部的allocator对象对datasize进行扩展到原来的两倍，
    // 并将length设置为原来的两倍
    pub fn extend(self: *BitStream) !void {
        const newDataSize = self.dataSize * 2;
        const newData = try self.allocator.realloc(self.data, newDataSize);
        self.data = newData;
        self.length = self.length * 2;
        self.dataSize = newDataSize;
    }
    // 获取bitstream中的第index个bit
    pub fn getBit(self: *const BitStream, index: usize) !bool {
        if (index >= self.length) {
            return error.OutOfBounds;
        }
        const byteIndex = index / 8;
        const bitIndex = index % 8;
        return (self.data[byteIndex] & (@as(u8, 1) << bitIndex)) != 0;
    }
    // 清空bitstream中的所有bit
    pub fn clear(self: *BitStream) void {
        self.length = 0;
    }
};
