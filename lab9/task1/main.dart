Future<String> createOrderMessage() async {
  var information = await fetchUserOrder();
  return 'User Information is: $information';
}

Future<String> fetchUserOrder() =>
    // Imagine that this function is
    // more complex and slow.
    Future.delayed(
      const Duration(seconds: 3),
      () =>
          '\n\t\t\t\tName: Muhammad Kamran\n\t\t\t\tClass: BESE-11B\n\t\t\t\tCMS ID: 331898\n\t\t\t\tLab: MAD_Lab_09',
    );

Future<void> main() async {
  print('\nFetching User Details...');
  print(await createOrderMessage());
}
