// SPDX-License-Identifier: MIT
// UnFlock Authors: see AUTHORS.txt

use crate::math::*;
use bevy::math::Vec3;

#[test]
fn test_rand_changes() {
    assert_ne!(rand(), rand());
}
#[test]
fn test_rand_greater_min() {
    assert_eq!(rand() >= RANDOM_MIN, true);
}
#[test]
fn test_rand_smaller_max() {
    assert_eq!(rand() <= RANDOM_MAX, true);
}

#[test]
fn test_clamp_self_min() {
    let mut value = 0.0;
    let res = value.clamp_self_to(1.0, 4.0);
    assert_eq!(1.0, value);
    assert_eq!(1.0, res);
}
#[test]
fn test_clamp_self_max() {
    let mut value = 10.0;
    let res = value.clamp_self_to(1.0, 4.0);
    assert_eq!(4.0, value);
    assert_eq!(4.0, res);
}
#[test]
fn test_clamp_self_in_range() {
    let mut value = 2.0;
    let res = value.clamp_self_to(1.0, 4.0);
    assert_eq!(2.0, value);
    assert_eq!(2.0, res);
}

#[test]
fn test_clamp_min() {
    let value = 0.0;
    let res = value.clamp_to(1.0, 4.0);
    assert_eq!(0.0, value);
    assert_eq!(1.0, res);
}
#[test]
fn test_clamp_max() {
    let value = 10.0;
    let res = value.clamp_to(1.0, 4.0);
    assert_eq!(10.0, value);
    assert_eq!(4.0, res);
}
#[test]
fn test_clamp_in_range() {
    let value = 2.0;
    let res = value.clamp_to(1.0, 4.0);
    assert_eq!(2.0, value);
    assert_eq!(2.0, res);
}

#[test]
fn test_min() {
    let l1_p1 = Vec3::new(-2., -1., 0.);
    let l1_p2 = Vec3::new(2., 1., 0.);
    let min_values = l1_p1.min(l1_p2);
    assert_eq!(-2., min_values.x);
    assert_eq!(-1., min_values.y);
}
#[test]
fn test_max() {
    let l1_p1 = Vec3::new(-2., -1., 0.);
    let l1_p2 = Vec3::new(2., 1., 0.);
    let max_values = l1_p1.max(l1_p2);
    assert_eq!(2., max_values.x);
    assert_eq!(1., max_values.y);
}
