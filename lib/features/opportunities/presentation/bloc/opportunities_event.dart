import 'package:equatable/equatable.dart';

abstract class OpportunitiesEvent extends Equatable {
  const OpportunitiesEvent();

  @override
  List<Object?> get props => [];
}

class OpportunitiesLoadRequested extends OpportunitiesEvent {
  const OpportunitiesLoadRequested();
}

class OpportunitiesRefreshRequested extends OpportunitiesEvent {
  const OpportunitiesRefreshRequested();
}

class OpportunitiesFiltersApplied extends OpportunitiesEvent {
  final String budgetRange;
  final Set<String> roles;
  final Set<String> industries;
  final Set<String> locations;
  final String rating;

  const OpportunitiesFiltersApplied({
    required this.budgetRange,
    required this.roles,
    required this.industries,
    required this.locations,
    required this.rating,
  });

  @override
  List<Object?> get props => [
        budgetRange,
        roles,
        industries,
        locations,
        rating,
      ];
}

class OpportunitiesFiltersCleared extends OpportunitiesEvent {
  const OpportunitiesFiltersCleared();
}

class OpportunityApplyRequested extends OpportunitiesEvent {
  final String opportunityId;

  const OpportunityApplyRequested(this.opportunityId);

  @override
  List<Object?> get props => [opportunityId];
}