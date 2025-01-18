const std = @import("std");
const math = std.math;
const testing = std.testing;

const Self = @This();

e: [3]f64,

pub fn init(e1: f64, e2: f64, e3: f64) Self {
    return Self{ .e = .{ e1, e2, e3 } };
}

pub fn zero() Self {
    return Self.init(0, 0, 0);
}

pub fn x(self: Self) f64 {
    return self.e[0];
}

pub fn y(self: Self) f64 {
    return self.e[1];
}

pub fn z(self: Self) f64 {
    return self.e[2];
}

pub fn neg(self: Self) Self {
    return Self.init(-self.e[0], -self.e[1], -self.e[2]);
}

pub fn add(self: *Self, other: Self) void {
    self.e[0] += other.e[0];
    self.e[1] += other.e[1];
    self.e[2] += other.e[2];
}

pub fn scale(self: *Self, t: f64) void {
    self.e[0] *= t;
    self.e[1] *= t;
    self.e[2] *= t;
}

pub fn lengthSquared(self: Self) f64 {
    return self.e[0] * self.e[0] + self.e[1] * self.e[1] + self.e[2] * self.e[2];
}

pub fn length(self: Self) f64 {
    return math.sqrt(self.lengthSquared());
}

pub fn cross(u: Self, v: Self) Self {
    return Self.init(
        u.e[1] * v.e[2] - u.e[2] * v.e[1],
        u.e[2] * v.e[0] - u.e[0] * v.e[2],
        u.e[0] * v.e[1] - u.e[1] * v.e[0],
    );
}

pub fn unitVector(v: Self) Self {
    const len = v.length();
    return Self.init(v.e[0] / len, v.e[1] / len, v.e[2] / len);
}

pub fn print(self: Self) void {
    std.debug.print("{d} {d} {d}\n", .{ self.e[0], self.e[1], self.e[2] });
}

test "vector addition" {
    var u = Self.init(1, 2, 3);
    const v = Self.init(2, 3, 4);
    u.add(v);

    try testing.expectEqual(u.x(), 3);
    try testing.expectEqual(u.y(), 5);
    try testing.expectEqual(u.z(), 7);
}

test "vector scale" {
    var u = Self.init(0, 1, 2);
    u.scale(3);

    try testing.expectEqual(u.x(), 0);
    try testing.expectEqual(u.y(), 3);
    try testing.expectEqual(u.z(), 6);
}

test "vector length" {
    const u = Self.init(3, 0, 4);
    try testing.expectEqual(u.length(), 5);
}
