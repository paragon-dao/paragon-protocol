# Collaborative Patent Document Secret Sharing & IPFS Pinning Strategy

## Overview

Paragon DAO's innovative approach to decentralized patent protection relies on a collaborative workflow that ensures:
- **Secure, verifiable, and immutable patent documentation.**
- **Dynamic secret sharing among verified inventors and resonants.**
- **A robust mechanism for document availability using IPFS pinning.**

This document outlines our strategy for secret sharing, re-splitting of decryption keys, and collaborative document updates while ensuring that only a predetermined threshold of resonants (not all) is required to access or update a patent document.

---

## 1. Document Preparation & Encryption

1. **Patent Document Drafting:**
   - Inventors draft their provisional patent application using our AI-powered tool.
   - The document includes metadata (title, abstract, technical details) and supporting files (diagrams, prior art, etc.).

2. **Encryption Using MetaMask:**
   - The inventor connects their MetaMask wallet.
   - A unique encryption key is derived from the wallet’s credentials.
   - The document is encrypted locally before being uploaded.

3. **Upload to IPFS:**
   - The encrypted document is uploaded to IPFS.
   - The resulting content identifier (CID) is stored on-chain as part of the patent record.
   - **IPFS Pinning:**  
     Each member, upon downloading the document, pins it to their own IPFS node to ensure high availability and redundancy. This guarantees that if a member loses their local copy, it can be retrieved from other nodes.

---

## 2. Secret Sharing & Collaborative Access

### A. Initial Secret Sharing (Using Shamir’s Secret Sharing)
- The master decryption key is split into _n_ shares using Shamir’s Secret Sharing scheme.
- A threshold _t_ (e.g., _t = 3_ out of _n = 5_) is set so that any combination of _t_ verified members can reconstruct the key.
- The originator holds the complete key and controls the initial distribution of shares.

### B. Dynamic Re-Splitting on Membership Changes
- **On Member Join/Leave:**
  - When a new resonant is verified and added to the group, the system triggers a re-splitting process.
  - The owner (originator) or a trusted core group re-runs the secret sharing algorithm with the updated group size.
- **Threshold for Access:**
  - Only a predetermined subset of the group (the required threshold, not every member) must participate in the decryption meeting.
  - This ensures a balance between security and convenience.

### C. Collaborative Decryption Meeting
- **Meeting Protocol:**
  - A scheduled meeting (virtual or in-person) is organized where the required threshold of resonants (e.g., 3 out of 5) join the decryption process.
  - Each participant provides their secret share, and the system reconstructs the master key.
- **Document Update:**
  - After decryption, each participant downloads the decrypted document to their local machine.
  - They review, suggest updates, and, if needed, edit the document collaboratively.
  - Once the collective version is finalized, the group re-encrypts the document with a new master key.
- **Re-Splitting New Secret:**
  - The new master key is re-split among the current verified members.
  - The updated secret shares are then distributed (via smart contracts or secure off-chain channels) to all members.
  - A new version number is logged on-chain to track the update.

---

## 3. IPFS Storage & Pinning

- **Decentralized Storage:**
  - The encrypted document is stored on IPFS, ensuring a distributed and immutable record.
- **Member Responsibility:**
  - Each member, upon downloading the document, is prompted to "pin" the document using their own IPFS node or via a provided service.
  - This creates multiple copies across the network, ensuring availability even if one node fails.
- **Automated Pinning Verification:**
  - The system periodically checks the status of the pinned documents.
  - If a member’s node is not pinning the document, a notification is sent, and alternative pinning solutions are suggested.
- **Version Control:**
  - Each update to the document creates a new IPFS CID.
  - The blockchain record is updated with the new CID and version number, allowing easy retrieval of the latest document.

---

## 4. Benefits of This Approach

- **Enhanced Security:**  
  The use of MetaMask for encryption, combined with Shamir’s Secret Sharing, ensures that no single entity can unilaterally decrypt the document.

- **Collaborative Governance:**  
  Only a threshold of verified resonants is required to access or update the document, ensuring that collaborative decisions are enforced without the need for every member to participate every time.

- **Document Availability & Redundancy:**  
  IPFS pinning by each member guarantees that the document remains available, providing a resilient backup mechanism in a decentralized environment.

- **Immutable Audit Trail:**  
  Every update, re-splitting event, and membership change is recorded on-chain, providing an immutable history of the document’s evolution.

- **Incentivized Collaboration:**  
  The system encourages inventors and resonants to contribute by rewarding them based on their involvement in maintaining and updating the document (reflected through the Coherence Index and related mechanisms).

---

## 5. Conclusion

This workflow is designed to ensure that:
- **Patent documents remain secure and only accessible to authorized parties.**
- **Collaborative updates are managed through a structured, transparent process.**
- **The system scales dynamically with membership changes, maintaining integrity through re-splitting of secret shares.**
- **IPFS pinning provides robust, decentralized storage, ensuring continuous availability of the document.**

By implementing these mechanisms, Paragon DAO empowers inventors to protect and develop their ideas while fostering a truly collaborative environment. This approach not only secures intellectual property but also democratizes the innovation process, making it accessible to everyone.

---

*End of Document*

