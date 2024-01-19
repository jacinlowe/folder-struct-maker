import 'package:flutter/material.dart';

enum OrderStatusEnum {
  processed(
      color: Colors.yellow,
      title: 'Processed',
      description: 'Your order is being processed.',
      icon: Icons.timer_outlined),
  packaging(
      color: Colors.purple,
      title: 'Packaging',
      description: "Your order is being boxed.",
      icon: Icons.check_box_outline_blank_outlined),
  inTransit(
      color: Colors.blue,
      title: 'In Transit',
      description: "Your order is on it's way to you.",
      icon: Icons.delivery_dining_outlined),
  delivered(
      color: Colors.green,
      title: 'Delivered',
      description: 'Thank you for shopping with us',
      icon: Icons.check_circle_outline_outlined);

  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const OrderStatusEnum(
      {required this.title,
      required this.description,
      required this.icon,
      required this.color});
}
