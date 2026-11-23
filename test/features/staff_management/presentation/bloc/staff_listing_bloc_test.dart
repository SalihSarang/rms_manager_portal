import 'package:flutter_test/flutter_test.dart';
import 'package:manager_portal/core/utils/image_picker_service/cloudinary_service/cloudinary_service.dart';
import 'package:manager_portal/features/staff_management/domain/repository/staff_repository.dart';
import 'package:manager_portal/features/staff_management/domain/usecases/delete_staff.dart';
import 'package:manager_portal/features/staff_management/domain/usecases/get_all_staffs.dart';
import 'package:manager_portal/features/staff_management/domain/usecases/get_staff_details.dart';
import 'package:manager_portal/features/staff_management/domain/usecases/update_staff.dart';
import 'package:manager_portal/features/staff_management/presentation/bloc/staff_listing/staff_listing_bloc.dart';
import 'package:rms_shared_package/enums/enums.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';

class FakeStaffRepository implements StaffRepository {
  final List<StaffModel> _staffList;
  FakeStaffRepository(this._staffList);

  @override
  Future<void> addNewStaff(StaffModel staff) async => _staffList.add(staff);

  @override
  Future<void> deleteStaff(String staffId) async =>
      _staffList.removeWhere((s) => s.id == staffId);

  @override
  Future<List<StaffModel?>> getAllStaffs() async => List.from(_staffList);

  @override
  Future<StaffModel> getStaffDetails(String staffId) async =>
      _staffList.firstWhere((s) => s.id == staffId);

  @override
  Future<void> updateStaff(StaffModel staff) async {
    final idx = _staffList.indexWhere((s) => s.id == staff.id);
    if (idx != -1) _staffList[idx] = staff;
  }

  @override
  Future<String> createNewUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async => 'new-uid';
}

class FakeCloudinaryService implements CloudinaryService {
  @override
  Future<void> deleteImage(String publicId) async {}
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late StaffListingBloc bloc;
  late FakeStaffRepository repo;

  final sampleStaffs = [
    StaffModel(
      id: '1',
      name: 'Gordon Ramsay',
      email: 'gordon@restaurant.com',
      phoneNumber: '+1987654321',
      role: UserRole.chef,
      avatar: '',
      idProof: '',
      isActive: true,
      shiftStatus: ShiftStatus.notStarted,
    ),
    StaffModel(
      id: '2',
      name: 'John Waiter',
      email: 'john@restaurant.com',
      phoneNumber: '+1122334455',
      role: UserRole.waiter,
      avatar: '',
      idProof: '',
      isActive: true,
      shiftStatus: ShiftStatus.notStarted,
    ),
    StaffModel(
      id: '3',
      name: 'Alice Cashier',
      email: 'alice@restaurant.com',
      phoneNumber: '+1555666777',
      role: UserRole.cashier,
      avatar: '',
      idProof: '',
      isActive: false,
      shiftStatus: ShiftStatus.notStarted,
    ),
  ];

  setUp(() {
    repo = FakeStaffRepository(sampleStaffs);
    bloc = StaffListingBloc(
      getAllStaffs: GetAllStaffs(repo),
      getStaffDetails: GetStaffDetails(repo),
      deleteStaff: DeleteStaffUsecase(repo),
      updateStaff: UpdateStaffUsecase(repo),
      cloudinaryService: FakeCloudinaryService(),
    );
  });

  tearDown(() {
    bloc.close();
  });

  test('LoadStaffs populates allStaffs and staffs', () async {
    bloc.add(LoadStaffs());
    await expectLater(
      bloc.stream,
      emitsInOrder([
        isA<StaffListingLoading>(),
        predicate<StaffListingLoaded>((state) =>
            state.allStaffs.length == 3 &&
            state.staffs.length == 3 &&
            state.searchQuery == '' &&
            state.selectedRole == 'All'),
      ]),
    );
  });

  test('SearchStaff filters by name, email, or phone', () async {
    bloc.add(LoadStaffs());
    await bloc.stream.firstWhere((s) => s is StaffListingLoaded);

    bloc.add(const SearchStaff('Gordon'));
    await expectLater(
      bloc.stream,
      emits(predicate<StaffListingLoaded>((state) =>
          state.staffs.length == 1 &&
          state.staffs.first.name == 'Gordon Ramsay' &&
          state.allStaffs.length == 3)),
    );

    // Search by email
    bloc.add(const SearchStaff('alice@'));
    await expectLater(
      bloc.stream,
      emits(predicate<StaffListingLoaded>((state) =>
          state.staffs.length == 1 &&
          state.staffs.first.name == 'Alice Cashier')),
    );

    // Clear search
    bloc.add(const SearchStaff(''));
    await expectLater(
      bloc.stream,
      emits(predicate<StaffListingLoaded>((state) =>
          state.staffs.length == 3 &&
          state.searchQuery == '')),
    );
  });

  test('FilterStaffByRole filters correctly by role chip', () async {
    bloc.add(LoadStaffs());
    await bloc.stream.firstWhere((s) => s is StaffListingLoaded);

    bloc.add(const FilterStaffByRole('Waiter'));
    await expectLater(
      bloc.stream,
      emits(predicate<StaffListingLoaded>((state) =>
          state.staffs.length == 1 &&
          state.staffs.first.name == 'John Waiter' &&
          state.selectedRole == 'Waiter')),
    );

    bloc.add(const FilterStaffByRole('Chef'));
    await expectLater(
      bloc.stream,
      emits(predicate<StaffListingLoaded>((state) =>
          state.staffs.length == 1 &&
          state.staffs.first.name == 'Gordon Ramsay')),
    );

    bloc.add(const FilterStaffByRole('All'));
    await expectLater(
      bloc.stream,
      emits(predicate<StaffListingLoaded>((state) => state.staffs.length == 3)),
    );
  });
}
