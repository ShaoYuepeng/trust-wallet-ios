// Copyright DApps Platform Inc. All rights reserved.

import TrustCore
import UIKit

protocol WalletViewCellDelegate: class {
    func didPress(viewModel: WalletAccountViewModel, in cell: WalletViewCell)
}

final class WalletViewCell: UITableViewCell {

    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var glassesImageView: UIImageView!
    @IBOutlet weak var walletTypeImageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var identiconImageView: TokenImageView!
    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var value: UILabel!

    weak var delegate: WalletViewCellDelegate?

    var viewModel: WalletAccountViewModel? {
        didSet {
            guard let model = viewModel else {
                return
            }
            title.text = model.title
            address.text = model.address
            glassesImageView.isHidden = !model.isWatch
            infoButton.tintColor = Colors.lightBlue
            identiconImageView.image = model.image
            selectedImageView.image = model.selectedImage
            if !model.wallet.multiWallet {
                value.isHidden = false
                value.text = model.value
            } else {
                value.isHidden = true
            }
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        updateSeparatorInset()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.viewModel = nil
    }

    @IBAction func infoAction(_ sender: Any) {
        guard let viewModel = viewModel else { return }
        delegate?.didPress(viewModel: viewModel, in: self)
    }

    private func updateSeparatorInset() {
        separatorInset = UIEdgeInsets(
            top: 0,
            left: layoutInsets.left + 80,
            bottom: 0, right: 0
        )
    }
}
