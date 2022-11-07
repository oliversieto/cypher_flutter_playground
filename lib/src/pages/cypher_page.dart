import 'package:flutter/material.dart';

import '../stores/cypher_store.dart';

class CypherPage extends StatefulWidget {
  const CypherPage({Key? key}) : super(key: key);

  @override
  State<CypherPage> createState() => _CypherPageState();
}

class _CypherPageState extends State<CypherPage> {
  final cypherStore = CypherStore();

  @override
  void initState() {
    super.initState();
    cypherStore.addListener(_listener);
  }

  @override
  void dispose() {
    cypherStore.removeListener(_listener);
    super.dispose();
  }

  void _listener() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cypher Page'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              onChanged: cypherStore.setWordToEncrypt,
              decoration: const InputDecoration(
                hintText: 'Enter text to encrypt',
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: cypherStore.encode,
            child: const Text('Encrypt'),
          ),
          const SizedBox(
            height: 10,
          ),
          Offstage(
            offstage: cypherStore.encryptedResult == null,
            child: Text(cypherStore.encryptedResult ?? ''),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              onChanged: cypherStore.setWordToDecrypt,
              decoration: const InputDecoration(
                hintText: 'Enter text to decrypt',
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
                onChanged: cypherStore.setKeyToDecrypt,
                decoration: const InputDecoration(
                  hintText: 'Enter key to decrypt',
                )),
          ),
          ElevatedButton(
            onPressed: cypherStore.decode,
            child: const Text('Decrypt'),
          ),
          const SizedBox(
            height: 10,
          ),
          Offstage(
            offstage: cypherStore.decryptedResult == null,
            child: Text(cypherStore.decryptedResult ?? ''),
          )
        ],
      ),
    );
  }
}
