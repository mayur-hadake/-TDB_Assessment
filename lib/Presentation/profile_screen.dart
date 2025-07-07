import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_dignitor_task/Data/Model/profile_response.dart';
import 'package:time_dignitor_task/Logic/Product/product_cubit.dart';
import 'package:time_dignitor_task/Logic/Profile/profile_cubit.dart';
import 'package:time_dignitor_task/Logic/Profile/profile_state.dart';
import 'package:time_dignitor_task/Presentation/product_list.dart';
import 'package:time_dignitor_task/Utils/AppColor.dart';
import 'package:time_dignitor_task/Utils/GlobalSnackbar.dart';
import 'package:time_dignitor_task/Utils/MyAlertDialogBox.dart';
import 'package:time_dignitor_task/Utils/ProgressDialog.dart';
import 'package:time_dignitor_task/Utils/sharedPeferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  ProfileResponse? user;
  SharedPre sp = SharedPre();

  @override
  void initState() {

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<ProfileCubit>().fetchProfileDat();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColorDark,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Profile',
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: AppColors.white),
            onPressed: () {
              MyAlertDialogBox.showMyAlertDialog(context, "Confirmation", "Are you sure want to logout?",
                onPositiveButtonClick:() {
                  //Navigate to profile screen
                  sp.removeAccessToken();
                  // Future.microtask((){
                  //   Navigator.of(context).pushAndRemoveUntil(
                  //     MaterialPageRoute(
                  //         builder: (context) => BlocProvider(
                  //           create: (_)=>LoginCubit(),
                  //           child: LoginScreen(),
                  //         )
                  //     ),(route) => false,
                  //   );
                  // });
                },
                positiveButtonText: "Yes",negativeButtonText: "No",
              );
            },
          ),
        ],
      ),
      body: BlocConsumer<ProfileCubit,ProfileState>(
        listener: (context, state) {
          if(state is ProfileLoadingState){
            ProgressDialog.show(context);
          }
          else if(state is ProfileLoadedState){
            ProgressDialog.hide(context);
            user = state.response;
          }
          else if(state is ProfileErrorState){
            ProgressDialog.hide(context);
            GlobalSnackbar.showError(context, state.error);
          }

        },
        builder: (context, state) {
          if(state is ProfileLoadedState){
            return profileScreenUi();
          }
          else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => ProductCubit(),
                child: ProductsListScreen(),
              ),
            )
        );
      },
        elevation: 8,
        tooltip: "Product",
        child: const Icon(Icons.shopping_bag_outlined),
      ),
    );
  }

  Widget profileScreenUi(){
    return SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header
            _buildProfileHeader(),
            const SizedBox(height: 24),

            // Personal Information
            _buildSectionTitle('Personal Information'),
            _buildInfoCard([
              _buildInfoRow('Full Name', '${user!.firstName} ${user!.lastName} ${user!.maidenName}'),
              _buildInfoRow('Gender', user!.gender!),
              _buildInfoRow('Age', user!.age.toString()),
              _buildInfoRow('Birth Date', user!.birthDate!),
              _buildInfoRow('Blood Group', user!.bloodGroup!),
              _buildInfoRow('Height', '${user!.height} cm'),
              _buildInfoRow('Weight', '${user!.weight} kg'),
              _buildInfoRow('Eye Color', user!.eyeColor!),
              _buildInfoRow('Hair', '${user!.hair!.color} ${user!.hair!.type}'),
            ]),
            const SizedBox(height: 16),

           /* // Contact Information
            _buildSectionTitle('Contact Information'),
            _buildInfoCard([
              _buildInfoRow('Email', user!.email!),
              _buildInfoRow('Phone', user!.phone!),
              _buildInfoRow('Address', _formatAddress(user!.address!)),
              _buildInfoRow('IP Address', user!.ip!),
              _buildInfoRow('MAC Address', user!.macAddress!),
            ]),
            const SizedBox(height: 16),

            // Education & Work
            _buildSectionTitle('Education & Work'),
            _buildInfoCard([
              _buildInfoRow('University', user!.university!),
              _buildInfoRow('Company', user!.company!.name!),
              _buildInfoRow('Department', user!.company!.department!),
              _buildInfoRow('Title', user!.company!.title!),
              _buildInfoRow('EIN', user!.ein!),
              _buildInfoRow('SSN', user!.ssn!),
            ]),
            const SizedBox(height: 16),

            // Financial Information
            _buildSectionTitle('Financial Information'),
            _buildInfoCard([
              _buildInfoRow('Bank Card', '${user!.bank!.cardType!} •••• ${user!.bank!.cardNumber?.substring(user!.bank!.cardNumber!.length - 4)}'),
              _buildInfoRow('Expires', user!.bank!.cardExpire!),
              _buildInfoRow('Currency', user!.bank!.currency!),
              _buildInfoRow('IBAN', user!.bank!.iban!),
            ]),
            const SizedBox(height: 16),

            // Crypto Information
            _buildSectionTitle('Crypto Wallet'),
            _buildInfoCard([
              _buildInfoRow('Coin', user!.crypto!.coin!),
              _buildInfoRow('Wallet', (user!.crypto!.wallet!)),
              _buildInfoRow('Network', user!.crypto!.network!),
            ]),
            const SizedBox(height: 16),

            // Technical Information
            _buildSectionTitle('Technical Information'),
            _buildInfoCard([
              _buildInfoRow('user! Agent', user!.userAgent!),
              _buildInfoRow('Role', user!.role!),
            ]),*/
          ],
        ),
      );
  }

  Widget _buildProfileHeader() {
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(user!.image!),
          ),
          const SizedBox(height: 16),
          Text(
            '${user!.firstName} ${user!.lastName}',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Text(
          //   '@${user!.username}',
          //   style: TextStyle(
          //     fontSize: 16,
          //     color: Colors.grey[600],
          //   ),
          // ),
          // Chip(
          //   label: Text(user!.role!.toUpperCase()),
          //   backgroundColor: user!.role == 'admin'
          //       ? Colors.red.withOpacity(0.2)
          //       : Colors.blue.withOpacity(0.2),
          //   labelStyle: TextStyle(
          //     color: user!.role == 'admin' ? Colors.red : Colors.blue,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style:  TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryColorDark,
        ),
      ),
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children,
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatAddress(Address address) {
    return '${address.address}, ${address.city}, ${address.stateCode} ${address.postalCode}, ${address.country}';
  }

  String _shortenWallet(String wallet) {
    return '${wallet.substring(0, 6)}...${wallet.substring(wallet.length - 4)}';
  }
}
