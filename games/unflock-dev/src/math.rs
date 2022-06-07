// SPDX-License-Identifier: MIT
// UnFlock Authors: see AUTHORS.txt

use bevy::math::Vec2;
use bevy::math::Vec3;
use bevy::prelude::Quat;
use bevy::prelude::Transform;
use rand::prelude::*;

/// represents a 2D polar coordinate with radius (r) and distance to (0, 0) (d)
#[derive(Clone, Copy, Debug)]
pub struct Polar2d {
    // radius
    pub r: f32,
    // distance
    pub d: f32,
}

impl Polar2d {
    /// convert Polar2d into a Vec3
    /// x and y are calculated from self.r and self.d
    /// z is set to the value of parameter z
    pub fn into_3d(&self, z: f32) -> Vec3 {
        Vec3::new(self.r * self.d.cos(), self.r * self.d.sin(), z)
    }
}

/// convert Polar2d into Vec2
impl Into<Vec2> for Polar2d {
    fn into(self) -> Vec2 {
        Vec2::new(self.r * self.d.cos(), self.r * self.d.sin())
    }
}

/// convert Polar2d into a Vec3 (set Vec3::z to 0.)
impl Into<Vec3> for Polar2d {
    fn into(self) -> Vec3 {
        self.into_3d(0.)
    }
}

/// Trait co clamp values to interval min..=max
pub trait Clamp {
    fn clamp_to(&self, min: Self, max: Self) -> Self;
    fn clamp_self_to(&mut self, min: Self, max: Self) -> Self;
}

/// Clamp f32 values to min..=max
impl Clamp for f32 {
    fn clamp_to(&self, min: Self, max: Self) -> Self {
        self.max(min).min(max)
    }
    fn clamp_self_to(&mut self, min: Self, max: Self) -> Self {
        *self = self.max(min).min(max);
        *self
    }
}

/// for a box (height x widht) and a segment_count,
/// get the equidistant difference between two points as polar coordinate
/// so that all segment_count points can be arranged in a circle
pub(crate) fn get_offset(height: f32, width: f32, segment_count: u32) -> Polar2d {
    Polar2d {
        // smallest of height and width, divide by 2 for radius, shortened by 10%
        r: height.min(width) / 2.0 * 0.9,
        d: 2.0 * std::f32::consts::PI / segment_count as f32,
    }
}

/// Given two points p1 and p2
/// return a (transform, length) tuple, where
/// length = distance between p1 and p2
/// transform = point in the middle of the connecting line between p1 and p2
pub(crate) fn xy_transform_for(p1: Vec3, p2: Vec3, z_order: f32) -> (Transform, f32) {
    let diff = (p2 - p1).truncate();
    let length = diff.length();
    let angle = diff.y.atan2(diff.x);

    let mut translation = (p1 + p2) / 2.0;
    translation.z = z_order;
    let mut transform = Transform::from_translation(translation);
    transform.rotation = Quat::from_rotation_z(angle);
    (transform, length)
}

/// lower bound of the random generator number interval
pub(crate) const RANDOM_MIN: i32 = -300;
/// upper bound of the random generator number interval
pub(crate) const RANDOM_MAX: i32 = 300;

/// get a random number in the interval RANDOM_MIN..=RANDOM_MAX
pub(crate) fn rand() -> i32 {
    thread_rng().gen_range(RANDOM_MIN..=RANDOM_MAX)
}

/// trait for checking if two numbers have the same sign
pub trait SameSign<T> {
    /// return true, if self and other have the same sign, false otherwise
    fn same_sign(&self, other: T) -> bool;
}

/// implement SameSign for i32
impl SameSign<i32> for i32 {
    fn same_sign(&self, other: i32) -> bool {
        (self ^ other) >= 0
    }
}
