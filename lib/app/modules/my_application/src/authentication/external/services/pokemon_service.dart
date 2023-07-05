import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_with_firebase/models/poke_model.dart';

class PokemonService {
  Future<void> savePokemon(String pokemonName) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final pokemonData = {
          'name': pokemonName,
        };
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .collection('Pokemon')
            .add(pokemonData);
      }
    } catch (e) {
      print('Erro ao salvar o pokemon: $e');
      // Tratar o erro aqui se necessário.
    }
  }

  Future<void> updatePokemonName(String pokemonId, String newName) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .collection('Pokemon')
            .doc(pokemonId)
            .update({'name': newName});
      }
    } catch (e) {
      print('Erro ao atualizar o nome do pokemon: $e');
      // Tratar o erro aqui se necessário.
    }
  }

  Future<void> deletePokemon(String pokemonId) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .collection('Pokemon')
            .doc(pokemonId)
            .delete();
      }
    } catch (e) {
      print('Erro ao excluir o pokemon: $e');
      // Tratar o erro aqui se necessário.
    }
  }
}
