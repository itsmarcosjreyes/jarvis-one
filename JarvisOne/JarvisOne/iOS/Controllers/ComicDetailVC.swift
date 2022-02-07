import Foundation
import UIKit
import RxSwift
import RxCocoa

final class ComicDetailVC: UIViewController {
    private var viewModel: ComicDetailVM?
    weak var coordinator: ComicDetailCoordinator?
    internal var activityIndicatorView: UIView?
    private var previousComicButton = UIButton()
    private var nextComicButton = UIButton()
    private let bag = DisposeBag()

    private lazy var tableView: UITableView = {
        let tableView: UITableView = .init(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 200.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.contentInset.bottom = .jvoSpace48
        tableView.registerCells([
            ComicDetailQuickActionCell.self,
            ComicDetailTitleCell.self,
            ComicDetailDescriptionCell.self
        ])
        return tableView
    }()

    private lazy var bottomNavigatorContainerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .jvoBackground
        return view
    }()

    init(viewModel: ComicDetailVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .fullScreen
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setNavigationStyle(for: .dismissOnly)
        subscribe()
        viewModel?.start()
    }

    private func setupUI() {
        view.backgroundColor = .jvoBackground

        view.addSubview(tableView)
        view.addSubview(bottomNavigatorContainerView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            bottomNavigatorContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomNavigatorContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomNavigatorContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomNavigatorContainerView.heightAnchor.constraint(equalToConstant: .jvoSpace80)
        ])

        previousComicButton = UIButton(frame: .zero)
        previousComicButton.setTitle(Constants.Strings.previous.value.uppercased(), for: .normal)
        previousComicButton.setStyle(for: .bottomNavigationLeft, icon: .jvoPrevious)

        nextComicButton = UIButton(frame: .zero)
        nextComicButton.setTitle(Constants.Strings.next.value.uppercased(), for: .normal)
        nextComicButton.setStyle(for: .bottomNavigationRight, icon: .jvoNext)

        bottomNavigatorContainerView.addSubview(previousComicButton)
        bottomNavigatorContainerView.addSubview(nextComicButton)

        NSLayoutConstraint.activate([
            previousComicButton.heightAnchor.constraint(equalToConstant: .jvoSpace40),
            previousComicButton.widthAnchor.constraint(equalToConstant: 120.0),
            previousComicButton.leadingAnchor.constraint(equalTo: bottomNavigatorContainerView.leadingAnchor, constant: .jvoSpaceGutter),
            previousComicButton.topAnchor.constraint(equalTo: bottomNavigatorContainerView.topAnchor),

            nextComicButton.heightAnchor.constraint(equalToConstant: .jvoSpace40),
            nextComicButton.widthAnchor.constraint(equalToConstant: 120.0),
            nextComicButton.trailingAnchor.constraint(equalTo: bottomNavigatorContainerView.trailingAnchor, constant: -.jvoSpaceGutter),
            nextComicButton.topAnchor.constraint(equalTo: bottomNavigatorContainerView.topAnchor)
        ])
    }

    private func subscribe() {
        viewModel?.isLoading.observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] isLoading in
                if isLoading {
                    self?.showActivityIndicator()
                } else {
                    self?.hideActivityIndicator()
                }
            })
            .disposed(by: bag)

        viewModel?.comicDataContainer
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.tableView.reloadWithCrossDissolve()
            })
            .disposed(by: bag)

        previousComicButton.rx.tap
            .subscribe { [weak self] event in
                self?.viewModel?.previousComic()
            }
            .disposed(by: bag)

        nextComicButton.rx.tap
            .subscribe { [weak self] event in
                self?.viewModel?.nextComic()
            }
            .disposed(by: bag)
    }

    func dismissVC() {
        coordinator?.dismissViewController()
    }
}

extension ComicDetailVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return ComicDetailSection.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // For the sake of this demo, always returning 1
        return 1
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = ComicDetailSection(rawValue: indexPath.section) else {
            return UITableViewCell()
        }

        switch section {
        case .quickActions:
            let cell: ComicDetailQuickActionCell = tableView.dequeReusableCell(for: indexPath)
            cell.comicFormatter = viewModel?.getComicFormatter()
            return cell

        case .title:
            let cell: ComicDetailTitleCell = tableView.dequeReusableCell(for: indexPath)
            cell.comicFormatter = viewModel?.getComicFormatter()
            return cell

        case .description:
            let cell: ComicDetailDescriptionCell = tableView.dequeReusableCell(for: indexPath)
            cell.comicFormatter = viewModel?.getComicFormatter()
            return cell
        }
    }
}

extension ComicDetailVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Nothing for now for this Demo
    }
}

extension ComicDetailVC: ActivityIndicatorDisplayable {}
extension ComicDetailVC: ModalDismissable {}
