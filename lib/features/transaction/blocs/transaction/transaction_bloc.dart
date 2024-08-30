import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kasirsuper/core/core.dart';
import 'package:kasirsuper/features/transaction/transaction.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionState.initial()) {
    on<GetTransactionEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: Status.loading));

        final service = await TransactionService.getAll(event.type);

        emit(state.copyWith(status: Status.success, transactions: service));
      } catch (e) {
        emit(state.copyWith(status: Status.failure, error: e.toString()));
      }
    });

    on<CekQRTransactionEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: Status.loading));

        final service = await XenditService.cekQR(state.item?.qrId ?? '');

        if (service == TypeEnum.paid) {
          final item = state.item!.copyQr(typeX: TypeEnum.paid);
          final result = await TransactionService.update(item);

          emit(state.copyWith(status: Status.processed, item: result));
        }
      } catch (e) {
        emit(state.copyWith(status: Status.failure, error: e.toString()));
      }
    });

    on<CreateQRTransactionEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: Status.loading));

        final service = await XenditService.createQR(
          amount: event.transaction.amount - event.transaction.discount,
          referenceId: event.transaction.referenceId,
        );

        final transaction = await TransactionService.insert(
          event.transaction.copyQr(
            qrIdX: service.$1,
            qrStringX: service.$2,
          ),
        );

        emit(state.copyWith(status: Status.success, item: transaction));
      } catch (e) {
        emit(state.copyWith(status: Status.failure, error: e.toString()));
      }
    });

    on<CreateTransactionEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: Status.loading));

        if (event.referenceId != null) {
          final item = await TransactionService.update(
            state.item!.copyQr(typeX: TypeEnum.paid),
          );

          emit(state.copyWith(status: Status.success, item: item));
        } else {
          final item = await TransactionService.insert(event.transaction);
          emit(
            state.copyWith(
              status:
                  event.type == TypeEnum.paid ? Status.success : Status.apply,
              item: item,
            ),
          );
        }
      } catch (e) {
        emit(state.copyWith(status: Status.failure, error: e.toString()));
      }
    });

    on<GetDetailTransactionEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: Status.loading));

        final item = await TransactionService.detail(event.referenceId);

        emit(
          state.copyWith(status: Status.success, item: item),
        );
      } catch (e) {
        emit(state.copyWith(status: Status.failure, error: e.toString()));
      }
    });
  }
}
