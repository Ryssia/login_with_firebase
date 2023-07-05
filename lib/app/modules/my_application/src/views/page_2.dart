import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_with_firebase/app/modules/my_application/src/authentication/external/services/pokemon_service.dart';

class PokemonCrudPage extends StatefulWidget {
  @override
  _PokemonCrudPageState createState() => _PokemonCrudPageState();
}

class _PokemonCrudPageState extends State<PokemonCrudPage> {
  final PokemonService _pokemonService = PokemonService();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastre seus Pokemons'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nome do Pokemon',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final pokemonName = _nameController.text;
                _pokemonService.savePokemon(pokemonName);
                _nameController.clear();
              },
              child: Text('Salvar'),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('Pokemon')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final pokemons = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: pokemons.length,
                      itemBuilder: (context, index) {
                        final pokemon = pokemons[index];
                        final pokemonName = pokemon['name'] as String;
                        final pokemonId = pokemon.id;
                        return ListTile(
                          title: Text(pokemonName),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  _showEditDialog(pokemonId, pokemonName);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  _showDeleteDialog(pokemonId);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                  if (snapshot.hasError) {
                    return Text('Erro ao carregar os pokemons');
                  }
                  return CircularProgressIndicator();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showEditDialog(String pokemonId, String currentName) async {
    final TextEditingController _editController =
        TextEditingController(text: currentName);
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Editar Pokemon'),
          content: TextField(
            controller: _editController,
            decoration: InputDecoration(
              labelText: 'Novo Nome',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final newName = _editController.text;
                _pokemonService.updatePokemonName(pokemonId, newName);
                Navigator.pop(context);
              },
              child: Text('Salvar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDeleteDialog(String pokemonId) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirmar exclusão'),
          content: Text('Deseja realmente excluir este pokemon?'),
          actions: [
            TextButton(
              onPressed: () {
                _pokemonService.deletePokemon(pokemonId);
                Navigator.pop(context);
              },
              child: Text('Confirmar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }
}
