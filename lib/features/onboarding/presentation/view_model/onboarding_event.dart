import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object?> get props => [];
}

class ChangePageEvent extends OnboardingEvent {
  final int page;

  const ChangePageEvent(this.page);

  @override
  List<Object?> get props => [page];
}

class NavigateToLoginEvent extends OnboardingEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateToLoginEvent({required this.context, required this.destination});

  @override
  List<Object?> get props => [context, destination];
}
