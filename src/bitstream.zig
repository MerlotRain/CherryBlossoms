const std = @import("std");
const Allocator = std.mem.Allocator;

pub fn BitStream() type {
    return struct {

        /// bit stream default size
        const DEFAULT_BUFSIZE:u32 = 128;

        allocator: Allocator,
        data: []u8,
        length: u32,
        datasize: u32,

        const Self = @This();

        pub fn init(allocator: Allocator) !Self {
            return Self{
                .allocator = allocator,
                .data = try allocator.alloc(u8, DEFAULT_BUFSIZE),
                .length = 0,
                .datasize = DEFAULT_BUFSIZE,
            };
        }
        pub fn deinit(self: *Self) void {
            self.allocator.free(self.data);
            self.* = undefined;
        }

        pub fn appendNumber(self: *Self, bits: usize, num: u32) bool {
            if(bits == 0) return false;

            _ = self;
            _ = num;
        }

        pub fn appendBuffer(self:*Self, size: usize, data: []u8) bool {
            _ = self;
            _ = size;
            _ = data;
        }
    };
}

      
