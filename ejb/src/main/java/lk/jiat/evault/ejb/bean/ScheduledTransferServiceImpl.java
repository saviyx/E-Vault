package lk.jiat.evault.ejb.bean;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import lk.jiat.evault.core.model.ScheduledTransfer;
import lk.jiat.evault.core.model.TransferFrequency;
import lk.jiat.evault.core.model.TransferStatus;
import lk.jiat.evault.core.service.ScheduledTransferService;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

@Stateless
public class ScheduledTransferServiceImpl implements ScheduledTransferService {

    @PersistenceContext
    private EntityManager em;

    @Override
    public void createScheduledTransfer(ScheduledTransfer transfer) {
        validateTransfer(transfer);
        transfer.setStatus(TransferStatus.PENDING);
        transfer.setActive(true);
        if (transfer.getNextExecutionDate() == null) {
            transfer.setNextExecutionDate(transfer.getStartDate());
        }
        em.persist(transfer);
    }

    @Override
    public ScheduledTransfer getScheduledTransferById(Long id) {
        return em.find(ScheduledTransfer.class, id);
    }

    @Override
    public List<ScheduledTransfer> getScheduledTransfersByCustomer(Long customerId) {
        TypedQuery<ScheduledTransfer> query = em.createQuery(
                "SELECT st FROM ScheduledTransfer st WHERE st.customer.id = :customerId " +
                        "AND st.active = true ORDER BY st.nextExecutionDate",
                ScheduledTransfer.class);
        query.setParameter("customerId", customerId);
        return query.getResultList();
    }

    @Override
    public List<ScheduledTransfer> getDueScheduledTransfers() {
        LocalDate today = LocalDate.now();
        TypedQuery<ScheduledTransfer> query = em.createQuery(
                "SELECT st FROM ScheduledTransfer st WHERE st.nextExecutionDate <= :today " +
                        "AND st.active = true AND st.status = :status",
                ScheduledTransfer.class);
        query.setParameter("today", today);
        query.setParameter("status", TransferStatus.PENDING);
        return query.getResultList();
    }

    @Override
    public void updateScheduledTransfer(ScheduledTransfer transfer) {
        validateTransfer(transfer);
        em.merge(transfer);
    }

    @Override
    public void cancelScheduledTransfer(Long transferId) {
        ScheduledTransfer transfer = getScheduledTransferById(transferId);
        if (transfer != null) {
            transfer.setActive(false);
            transfer.setStatus(TransferStatus.CANCELLED);
            em.merge(transfer);
        }
    }

    @Override
    public void processCompletedTransfer(ScheduledTransfer transfer) {
        transfer.setStatus(TransferStatus.COMPLETED);
        updateNextExecutionDate(transfer);
        em.merge(transfer);
    }

    private void updateNextExecutionDate(ScheduledTransfer transfer) {
        if (transfer.getFrequency() != TransferFrequency.ONCE) {
            LocalDate nextDate = transfer.getNextExecutionDate();
            switch (transfer.getFrequency()) {
                case DAILY:
                    nextDate = nextDate.plusDays(1);
                    break;
                case WEEKLY:
                    nextDate = nextDate.plusWeeks(1);
                    break;
                case MONTHLY:
                    nextDate = nextDate.plusMonths(1);
                    break;
            }

            if (transfer.getEndDate() == null || nextDate.isBefore(transfer.getEndDate())) {
                transfer.setNextExecutionDate(nextDate);
                transfer.setStatus(TransferStatus.PENDING);
            } else {
                transfer.setActive(false);
                transfer.setStatus(TransferStatus.COMPLETED);
            }
        } else {
            transfer.setActive(false);
            transfer.setStatus(TransferStatus.COMPLETED);
        }
    }

    private void validateTransfer(ScheduledTransfer transfer) {
        if (transfer == null) {
            throw new IllegalArgumentException("Transfer cannot be null");
        }
        if (transfer.getCustomer() == null) {
            throw new IllegalArgumentException("Customer is required");
        }
        if (transfer.getAmount() == null || transfer.getAmount().compareTo(BigDecimal.ZERO) <= 0) {
            throw new IllegalArgumentException("Amount must be positive");
        }
        if (transfer.getStartDate() == null) {
            throw new IllegalArgumentException("Start date is required");
        }
        if (transfer.getFrequency() == null) {
            throw new IllegalArgumentException("Frequency is required");
        }
        if (transfer.getRecipientAccount() == null || transfer.getRecipientAccount().isEmpty()) {
            throw new IllegalArgumentException("Recipient account is required");
        }
    }
}