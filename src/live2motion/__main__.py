import os.path
from argparse import ArgumentParser, Namespace

from ._vendor.exiftool import ExifToolHelper
from ._vendor.motionphoto2.Muxer import Muxer


def _get_arg_parser() -> ArgumentParser:
    parser = ArgumentParser(
        allow_abbrev=False,
    )

    parser.add_argument(
        '-i',
        '--image',
        type=str,
        required=True,
        help='path to a still photo',
    )

    parser.add_argument(
        '-v',
        '--video',
        type=str,
        required=True,
        help='path to a video',
    )

    parser.add_argument(
        '-o',
        '--output',
        type=str,
        required=True,
        help='path to the output motion photo',
    )

    # parser.add_argument(
    #     '-f',
    #     '--force',
    #     action='store_true',
    # )

    parser.add_argument(
        '-x',
        '--exiftool',
        default='exiftool',
        type=str,
        required=False,
        help='path to ExifTool executable',
    )

    return parser


def _check_args(args: Namespace) -> None:
    if not args.image or not os.path.isfile(args.image):
        raise FileNotFoundError(args.image)

    if not args.video or not os.path.isfile(args.video):
        raise FileNotFoundError(args.video)

    if not args.output:
        raise ValueError(args.output)
    if os.path.exists(args.output):
        raise FileExistsError(args.output)

    if not args.exiftool:
        raise FileNotFoundError(args.exiftool)


def main():
    parser = _get_arg_parser()
    args = parser.parse_args()
    _check_args(args)

    with ExifToolHelper(
        executable=args.exiftool,
        encoding='utf-8',
    ) as et:
        muxer = Muxer(
            image_fpath=args.image,
            video_fpath=args.video,
            exiftool=et,
            output_fpath=args.output,
        )
        muxer.mux()


if __name__ == '__main__':
    main()
