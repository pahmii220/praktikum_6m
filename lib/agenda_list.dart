import 'package:flutter/material.dart';
import 'agenda.dart';
import 'agenda_form.dart';
import 'agenda_service.dart';

class AgendaList extends StatefulWidget {
  const AgendaList({super.key});

  @override
  State<AgendaList> createState() => _AgendaListState();
}

class _AgendaListState extends State<AgendaList> {
  final _service = AgendaService();
  late Future<List<Agenda>> _agendaList;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  void _refresh() {
    setState(() {
      _agendaList = _service.getAll();
    });
  }

  void _delete(int id) async {
    await _service.delete(id);
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agenda')),
      body: FutureBuilder<List<Agenda>>(
        future: _agendaList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (_, i) {
                final item = data[i];
                return ListTile(
                  title: Text(item.judul),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.keterangan),
                      const SizedBox(height: 4),
                      Text(
                        'Alamat: ${item.alamat}',
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Jam: ${item.jam}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  isThreeLine: true,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AgendaForm(agenda: item),
                            ),
                          );
                          if (result == true) _refresh();
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _delete(item.id!),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          if (snapshot.hasError) {
            return Center(child: Text('Gagal memuat: ${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AgendaForm()),
          );
          if (result == true) _refresh();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
