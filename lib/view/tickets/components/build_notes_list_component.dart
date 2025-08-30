import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/tickets/ticket_work_notes.dart';

class BuildNotesListWidget extends StatelessWidget {
  final List<TicketWorkNotes> noteList;
  final int ticketID;
  final void Function(int index) onUpdate;

  const BuildNotesListWidget({
    Key? key,
    required this.noteList,
    required this.ticketID,
    required this.onUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 8),
      child: UL(
        children: List.generate(
          noteList.where((e) => e.note != null).length,
          (index) {
            TicketWorkNotes res = noteList.where((e) => e.note != null).toList()[index];
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(res.note.validate(), style: primaryTextStyle()).expand(),
                8.width,
                Row(
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        onUpdate(index);
                      },
                      child: Icon(
                        Icons.edit,
                        color: Colors.black,
                        size: 18,
                      ),
                    ),
                    10.width,
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        showConfirmDialogCustom(
                          context,
                          dialogType: DialogType.DELETE,
                          onAccept: (p0) {
                            ticketStartWorkStore.deleteNotes(
                              id: res.id ?? -1000,
                              ticketId: ticketID,
                            );
                          },
                        );
                      },
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 18,
                      ),
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
