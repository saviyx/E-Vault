package lk.jiat.evault.core.service;

import jakarta.ejb.Remote;
import lk.jiat.evault.core.model.ScheduledTransfer;
import java.util.List;


@Remote
public interface ScheduledTransferService {
    void createScheduledTransfer(ScheduledTransfer transfer);
    ScheduledTransfer getScheduledTransferById(Long id);
    List<ScheduledTransfer> getScheduledTransfersByCustomer(Long customerId);
    List<ScheduledTransfer> getDueScheduledTransfers();
    void updateScheduledTransfer(ScheduledTransfer transfer);
    void cancelScheduledTransfer(Long transferId);
    void processCompletedTransfer(ScheduledTransfer transfer);
}