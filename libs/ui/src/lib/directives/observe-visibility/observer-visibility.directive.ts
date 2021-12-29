import {
    AfterViewInit,
    ChangeDetectorRef,
    Directive,
    ElementRef,
    EventEmitter,
    Input,
    OnInit,
    Output
} from '@angular/core';
import {debounceTime, filter, Subject} from 'rxjs';

@Directive({
    selector: '[jfObserveVisibility]',
    exportAs: 'observer'
})

export class ObserverVisibilityDirective implements OnInit, AfterViewInit {

    private observer?: IntersectionObserver;
    private subject$ = new Subject<void>();

    public isVisible: boolean = false;

    @Input()
    threshold: number = 0.1;

    @Input()
    debounce: number = 1;

    @Output()
    visible: EventEmitter<void> = new EventEmitter<void>();

    constructor(private readonly element: ElementRef,
                private readonly changeDetector: ChangeDetectorRef) {
        this.subject$
            .pipe(
                debounceTime(this.debounce),
                filter(() => !this.isVisible)
            )
            .subscribe(() => {
                this.isVisible = true;
                this.changeDetector.markForCheck();
                this.observer!.disconnect();

                this.changeDetector.markForCheck();
            });
    }

    public ngOnInit(): void {
        this.createObserver();
    }

    public ngAfterViewInit(): void {
        this.startObserving();
    }

    public ngOnDestroy(): void {
        this.observer?.disconnect();
    }

    private createObserver(): void {
        const options = {
            rootMargin: '0px',
            threshold: this.threshold
        };

        this.observer = new IntersectionObserver((entries, observer) => {
            if (entries[0].isIntersecting) {
                this.subject$.next();
            }
        }, options);
    }

    private startObserving(): void {
        if (!this.observer) {
            return;
        }

        this.observer.observe(this.element.nativeElement);
    }
}
