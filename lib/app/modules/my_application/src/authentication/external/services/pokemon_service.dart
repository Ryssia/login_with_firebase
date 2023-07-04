import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PokemonService {
  Future<void> savePokemon(String pokemonName) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final pokemonData = {
          'name': pokemonName,
          'userId': user.uid,
        };
        await FirebaseFirestore.instance
            .collection('Pokemons')
            .add(pokemonData);
      }
    } catch (e) {
      print('Erro ao salvar o pokemon: $e');
      // Tratar o erro aqui se necessário.
    }
  }
}
