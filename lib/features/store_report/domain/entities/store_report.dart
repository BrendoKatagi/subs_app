import 'package:equatable/equatable.dart';

import 'package:substore_app/features/store_report/domain/entities/plans_active.dart';
import 'package:substore_app/shared/extensions/int_extensions.dart';

class StoreReport extends Equatable {
  final int? revenue;
  final int? tickets;
  final int? available;
  final int? done;
  final int? expired;
  final String? expiredPercentage;
  final List<ActivePlan>? activePlans;

  const StoreReport({
    this.revenue,
    this.tickets,
    this.available,
    this.done,
    this.expired,
    this.expiredPercentage,
    this.activePlans,
  });

  String get formattedRevenue => revenue?.toFormattedReais() ?? '';
  String valueOrZero(int? value) => (value ?? 0).toString();

  Map<String, String> get storeQuickValues => <String, String>{
        'Planos ativos': valueOrZero(activePlans?.length),
        'Renda mensal': formattedRevenue,
        'Bilhetes emitidos': valueOrZero(tickets),
        'Disponíveis': valueOrZero(available),
        'Check-ins': valueOrZero(done),
        'Expirados': valueOrZero(expired),
      };

  factory StoreReport.fromJson(Map<String, dynamic> json) => StoreReport(
        revenue: json['revenue'] as int?,
        tickets: json['tickets'] as int?,
        available: json['available'] as int?,
        done: json['done'] as int?,
        expired: json['expired'] as int?,
        expiredPercentage: json['expiredPercentage'] as String?,
        activePlans: (json['plansActive'] as List<dynamic>?)?.map((e) => ActivePlan.fromJson(e as Map<String, dynamic>)).toList(),
      );

  Map<String, dynamic> toJson() => {
        'revenue': revenue,
        'tickets': tickets,
        'available': available,
        'done': done,
        'expired': expired,
        'expiredPercentage': expiredPercentage,
        'plansActive': activePlans?.map((e) => e.toJson()).toList(),
      };

  StoreReport copyWith({
    int? revenue,
    int? tickets,
    int? available,
    int? done,
    int? expired,
    String? expiredPercentage,
    List<ActivePlan>? plansActive,
  }) {
    return StoreReport(
      revenue: revenue ?? this.revenue,
      tickets: tickets ?? this.tickets,
      available: available ?? this.available,
      done: done ?? this.done,
      expired: expired ?? this.expired,
      expiredPercentage: expiredPercentage ?? this.expiredPercentage,
      activePlans: plansActive ?? activePlans,
    );
  }

  @override
  List<Object?> get props {
    return [
      revenue,
      tickets,
      available,
      done,
      expired,
      expiredPercentage,
      activePlans,
    ];
  }
}
