import 'package:bloc/bloc.dart';
import 'package:scholarshuip_finder_app/features/home/domain/use_case/get_instituted_by_id_usecase.dart';
import 'package:scholarshuip_finder_app/features/home/presentation/view_model/scholor_provider_event.dart';
import 'package:scholarshuip_finder_app/features/home/presentation/view_model/scholor_provider_state.dart';



import '../../domain/use_case/add_instituted_usecase.dart';
import '../../domain/use_case/delete_instituted_usecase.dart';
import '../../domain/use_case/get_instituted_by_filter.dart';
import '../../domain/use_case/get_instituted_usecase.dart';
import '../../domain/use_case/update_instituted_udecase.dart';


class ScholarshipProviderBloc extends Bloc<ScholarshipProviderEvent, ScholarshipProviderState> {
  final AddScholarshipProviderUseCase addScholarshipProviderUseCase;
  final GetScholarshipProviderUseCase getScholarshipProvidersUseCase;
  final UpdateScholarshipProviderUseCase updateScholarshipProviderUseCase;
  final DeleteScholarshipProviderUseCase deleteScholarshipProviderUseCase;
   final GetScholarshipProviderByIdUseCase getScholarshipProviderByIdUseCase;
   final GetInstitutionsByFilterUseCase getInstitutionsByFilterUseCase;
  ScholarshipProviderBloc({
    required this.getInstitutionsByFilterUseCase,
    required this.addScholarshipProviderUseCase,
    required this.getScholarshipProvidersUseCase,
    required this.updateScholarshipProviderUseCase,
    required this.deleteScholarshipProviderUseCase,
    required this.getScholarshipProviderByIdUseCase,

  }) : super(const ScholarshipProviderState.initial()) {

    on<AddScholarshipProviderEvent>(_onAddScholarshipProvider);
    on<GetScholarshipProvidersEvent>(_onGetScholarshipProviders);
    on<UpdateScholarshipProviderEvent>(_onUpdateScholarshipProvider);
    on<DeleteScholarshipProviderEvent>(_onDeleteScholarshipProvider);
  on<GetScholarshipProviderByIdEvent>(_onGetScholarshipProvidersById);
    on<FetchScholarshipProvidersEvent>(_onGetScholarshipProvidersByFilter);
  }

  Future<void> _onAddScholarshipProvider(
      AddScholarshipProviderEvent event,
      Emitter<ScholarshipProviderState> emit,
      ) async {
    emit(state.copyWith(isLoading: true));
    final result = await addScholarshipProviderUseCase(event.params as ScholorProviderParams);

    result.fold(
          (failure) => emit(state.copyWith(isLoading: false, isError: true, errorMessage: failure.message)),
          (scholarshipProvider) => emit(state.copyWith(isLoading: false, isSuccess: true, scholarshipProvider: scholarshipProvider)),
    );
  }

  Future<void> _onGetScholarshipProviders(
      GetScholarshipProvidersEvent event,
      Emitter<ScholarshipProviderState> emit,
      ) async {
    emit(state.copyWith(isLoading: true));
    final result = await getScholarshipProvidersUseCase();

    result.fold(
          (failure) => emit(state.copyWith(isLoading: false, isError: true, errorMessage: failure.message)),
          (scholarshipProviders) => emit(state.copyWith(isLoading: false, isSuccess: true,
              scholarshipProviders: scholarshipProviders)),
    );
  }
  Future<void> _onGetScholarshipProvidersById(
      GetScholarshipProviderByIdEvent event,
      Emitter<ScholarshipProviderState> emit,
      ) async {
    emit(state.copyWith(isLoading: true));
    final result = await getScholarshipProviderByIdUseCase(event.id);

    result.fold(
          (failure) => emit(state.copyWith(isLoading: false, isError: true, errorMessage: failure.message)),
          (scholarshipProviders) => emit(state.copyWith(isLoading: false, isSuccess: true, scholarshipProviders: scholarshipProviders)),
    );
  }

  Future<void> _onUpdateScholarshipProvider(
      UpdateScholarshipProviderEvent event,
      Emitter<ScholarshipProviderState> emit,
      ) async {
    emit(state.copyWith(isLoading: true));
    final result = await updateScholarshipProviderUseCase(event.scholarshipProvider as UpdateScholarshipProviderParams);

    result.fold(
          (failure) => emit(state.copyWith(isLoading: false, isError: true, errorMessage: failure.message)),
          (_) => emit(state.copyWith(isLoading: false, isSuccess: true)),
    );
  }

  Future<void> _onDeleteScholarshipProvider(
      DeleteScholarshipProviderEvent event,
      Emitter<ScholarshipProviderState> emit,
      ) async {
    emit(state.copyWith(isLoading: true));
    final result = await deleteScholarshipProviderUseCase(event.id);

    result.fold(
          (failure) => emit(state.copyWith(isLoading: false, isError: true, errorMessage: failure.message)),
          (_) => emit(state.copyWith(isLoading: false, isSuccess: true)),
    );
  }

  Future<void> _onGetScholarshipProvidersByFilter(
      FetchScholarshipProvidersEvent event,
      Emitter<ScholarshipProviderState> emit,
      ) async {
    emit(state.copyWith(isLoading: true));

    try {
      final result = await getInstitutionsByFilterUseCase(
        cities: event.cities,
        countries: event.countries,
        courses: event.courses,
        searchQuery: event.searchQuery,
        scholarshipTypes: event.scholarshipTypes,
      );

      result.fold(
            (failure) {
          emit(state.copyWith(
            isLoading: false,
            isError: true,
            errorMessage: failure.message,
          ));
        },
            (scholarshipProviders) {
          emit(state.copyWith(
            isLoading: false,
            isSuccess: true,
            scholarshipProviders: scholarshipProviders,
          ));
        },
      );
    } catch (error) {
      emit(state.copyWith(
        isLoading: false,
        isError: true,
        errorMessage: error.toString(),
      ));
    }
  }
}