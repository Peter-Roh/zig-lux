const std = @import("std");
const vec = @import("../vec/vec.zig");

const point3 = vec.Vec3;
const Vec3 = vec.Vec3;

const Self = @This();

orig: point3,
dir: Vec3,

pub fn init(orig: point3, dir: Vec3) Self {
    return Self{
        .orig = orig,
        .dir = dir,
    };
}

pub fn origin() point3 {
    return Self.orig;
}

pub fn direction() Vec3 {
    return Self.dir;
}

pub fn at(t: f64) point3 {
    return Self.orig + t * Self.dir;
}
